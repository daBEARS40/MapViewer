//
//  MapViewTabViewModel.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//

import SwiftUI

@MainActor
final class MapViewerTabViewModel: ObservableObject {
    @Published var mapServices: [MapService] = []
    @Published var layerList: [Layer] = []
    
    let service: GeoserverService = GeoserverService()
    
    func getMapServices() -> [MapService] {
        return service.getMapServices()
    }
    
    func populateLayerHierarchy() async throws -> Void {
        mapServices = getMapServices()
        let wmsList: [WMSData] = try await service.getAllCapabilitiesForWMSList(mapServices: mapServices)

        for var wms in wmsList {
            for node in wms.node.childNodes {
                if (node.tag == "Name") {
                    if (!node.data.contains(":")) {
                        wms.root = node.data
                    }
                }
            }
            layerList.append(buildLayerList(node: wms.node, wms: wms))
        }
        
        print(layerList)
    }
    
    
    //TODO: recursion not working right now, not sure why
    func buildLayerList(node: XMLNode, wms: WMSData) -> Layer {
        let layer = Layer()
        
        layer.url = wms.url
        layer.user = wms.user
        layer.pass = wms.pass
        
        var minScale: Int = 0
        var crs: String = ""
        
        var childLayerNodes: [XMLNode] = []
        
        for childNode in node.childNodes {
            
            switch childNode.tag {
            case "Title":
                layer.title = node.data
                break
            case "Name":
                if (wms.root.isEmpty) {
                    layer.name = node.data
                } else {
                    layer.name = "\(wms.root):\(node.data)"
                }
                break
            case "KeywordList":
                if (node.data.isEmpty) {
                    layer.keywords = ["layerGroup", "layerContainer"]
                } else {
                    layer.keywords = getDataFromChildTags(node: node, tag: "Keyword")
                }
            case "MaxScaleDenominator":
                layer.maxScale = Int(node.data) ?? 25000000
                break
            case "MinScaleDenominator":
                minScale = Int(node.data) ?? 0
                break
            case "CRS":
                if (crs.isEmpty) {
                    crs = node.data
                }
                break
            case "Attribution":
                let attr = getDataFromChildTags(node: node, tag: "Attribution")
                if (attr.count > 0) {
                    layer.attribution = attr[0]
                }
            case "Layer":
                childLayerNodes.append(childNode)
                break
            default:
                break
            }
            
        }
        
        layer.minScale = minScale
        layer.geoserverSrs = crs
        
        if (childLayerNodes.count > 0) {
            layer.type = "LayerGroup"
            var children: [Layer] = []
            
            for childNode in childLayerNodes {
                children.append(buildLayerList(node: childNode, wms: wms))
            }
            
            if (children.count > 0) {
                children.reverse()
                layer.children = children
            }
        } else {
            layer.type = "Layer"
        }
        
        return layer
    }
    
    func getDataFromChildTags(node: XMLNode, tag: String) -> [String] {
        var data: [String] = []
        
        for childNode in node.childNodes {
            if (childNode.tag == tag) {
                data.append(childNode.data)
            }
        }
        
        return data
    }
}
