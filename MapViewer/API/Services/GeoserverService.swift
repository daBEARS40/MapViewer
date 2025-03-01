//
//  MapService.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//
import Foundation

import Foundation

struct GeoserverService {
    let baseUrl: String = "https://geoserver-pr2.i-opentech.com/geoserver/NorthVancouver/wms/?service=wms&version=1.3.0&request=GetCapabilities"
    let user = "rarmstrong"
    let pass = "Fr33f00d"
    //let wmsParser = WMSCapabilitiesParser()
    var userAndPass: String {
        return "\(user):\(pass)".data(using: .utf8)?.base64EncodedString() ?? ""
    }
    
    func getLayerCapability() async throws -> LayerDTO {
        guard let url = URL(string: baseUrl) else {
            throw GeoserverError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.setValue("Basic \(userAndPass)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            let xmlParser = WMSCapabilitiesParser(data: data)
            let tree = xmlParser.parse()
            return parseLayerCapability(node: tree ?? XMLNode(tag: "", data: "", attributes: [:], childNodes: []))
        }
    }
    
    func parseLayerCapability(node: XMLNode) -> LayerDTO {
        var rootLayer = LayerDTO()
        
        for xmlNode in node.childNodes {
            
        }
        
        return rootLayer
    }
}
