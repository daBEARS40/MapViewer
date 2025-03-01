//
//  MapService.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//
import Foundation

struct GeoserverService {
    let baseUrl: String = "https://geoserver-pr2.i-opentech.com/geoserver/NorthVancouver/wms/?service=wms&version=1.3.0&request=GetCapabilities"
    let user = "rarmstrong"
    let pass = "Fr33f00d"
    let wmsParser = WMSCapabilitiesParser()
    var userAndPass: String {
        return "\(user):\(pass)".data(using: .utf8)?.base64EncodedString() ?? ""
    }
    
    func getLayerCapabilities() {
        guard let url = URL(string: baseUrl) else { return }
        
        var request = URLRequest(url: url)
        request.setValue("Basic \(userAndPass)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                print(String(data: data, encoding: .utf8) ?? "No data")
            }
        }.resume()
    }
}
