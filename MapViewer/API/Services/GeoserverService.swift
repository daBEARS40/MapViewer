//
//  MapService.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//
import Foundation

struct GeoserverService {
    let baseUrl: String = "https://geoserver-pr2.i-opentech.com/geoserver/NorthVancouver/wms/?service=wms&version=1.3.0&request=GetCapabilities"
    let user = ""
    let pass = ""
    var userAndPass: String {
        return "\(user):\(pass)".data(using: .utf8)?.base64EncodedString() ?? ""
    }
    
    
    //let key: String = "b5e864961b0b4a258b3212656241402"
    //var cityName: String = "Abbotsford"
    //var days: Int = 14
    
    func getLayerCapability() async throws -> GeoserverResponseDTO {
        guard let url = URL(string: baseUrl) else {
            throw GeoserverError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(userAndPass)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print(response)
            throw GeoserverError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(GeoserverResponseDTO.self, from: data)
        } catch {
            print(error)
            throw GeoserverError.invalidData
        }
    }
}
