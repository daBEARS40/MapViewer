//
//  MapService.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//
import Foundation

enum GeoserverError: Error {
    case noRootLayerFound
}

struct GeoserverService {
    
    let getCapabilitiesEndPoint: String = "?service=wms&version=1.3.0&request=GetCapabilities"
    
    func getEncodedUserAndPass(user: String, pass: String) -> String {
        return "\(user):\(pass)".data(using: .utf8)?.base64EncodedString() ?? ""
    }
    
    //TODO: stub, should eventually store these. Learn SwiftData?
    func getMapServices() -> [MapService] {
        return [
            MapService(name: "North Vancouver WMS", url: "https://geoserver-pr2.i-opentech.com/geoserver/NorthVancouver/wms", user: "rarmstrong", pass: "Fr33f00d"),
            MapService(name: "City of Pitt Meadows", url: "https://geoserver-st.i-opentech.com/geoserver/PittMeadows/wms", user: "llevesque", pass: "Kenneth-0803"),
            MapService(name: "Soil Data WMS", url: "https://geo-autoag.i-opentech.com/geoserver/SoilData/wms", user: "rarmstrong", pass: "Fr33f00d")
        ]
    }
    
    func getAllCapabilitiesForWMSList(mapServices: [MapService]) async throws -> [WMSData] {
        return try await withThrowingTaskGroup(of: WMSData.self) { group in
            
            for mapService in mapServices {
                group.addTask {
                    try await getCapabilitiesForWMS(mapService: mapService)
                }
            }
            
            var WMSList: [WMSData] = []
            
            for try await wmsData in group {
                WMSList.append(wmsData)
            }
            
            return WMSList
        }
    }
    
    func getCapabilitiesForWMS(mapService: MapService) async throws -> WMSData {
        guard let url = URL(string: mapService.url + getCapabilitiesEndPoint) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.setValue("Basic \(getEncodedUserAndPass(user: mapService.user, pass: mapService.pass))", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            let xmlParser = WMSCapabilitiesParser(data: data)
            var tree = xmlParser.parse() ?? XMLNode(tag: "", data: "", attributes: [:], childNodes: [])
            return try getRootWMSDataFromCapabilities(node: &tree, mapService: mapService)
        } catch {
            throw GeoserverError.noRootLayerFound
        }
    }
    
    func getRootWMSDataFromCapabilities(node: inout XMLNode, mapService: MapService) throws -> WMSData {
        do {
            node = try getRootLayerNode(nodes: [node])
        } catch {
            throw GeoserverError.noRootLayerFound
        }
        
        let wmsData = WMSData(node: node, url: mapService.url, user: mapService.user, pass: mapService.pass, root: "")
        return wmsData
    }
    
    /**
        GetCapabilities calls return with the LayerGroup we need incased in an extra, unnecessary <Layer> XML node. We call getRootLayer to find this initial node, and
            once found, we grab the first <Layer> node within the unnecessary root <Layer>.
            ex) <Layer> North Vancouver Web Map Service, which we don't need, contains <Layer> NorthVancouver:NorthVancouver_GRP - which we do need.
     */
     
    func getRootLayerNode(nodes: [XMLNode]) throws -> XMLNode {
        for node in nodes {
            if (node.tag == "Layer") {
                //Get the real root node
                return try getRootRootLayerNode(nodes: node.childNodes)
            }
            if let foundNode = try? getRootLayerNode(nodes: node.childNodes) {
                return foundNode
            }
        }
        throw GeoserverError.noRootLayerFound
    }
    
    /**
        Here is where we get the real root layer we need.
     */
    
    func getRootRootLayerNode(nodes: [XMLNode]) throws -> XMLNode {
        for node in nodes {
            if (node.tag == "Layer") {
                return node
            }
        }
        throw GeoserverError.noRootLayerFound
    }
}
