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
    var userAndPass: String {
        return "\(user):\(pass)".data(using: .utf8)?.base64EncodedString() ?? ""
    }
    
    
    //let key: String = "b5e864961b0b4a258b3212656241402"
    //var cityName: String = "Abbotsford"
    //var days: Int = 14
    
    func getLayerCapability(completion: @escaping (Result<wmsData, Error>) -> Void){
        guard let url = URL(string: baseUrl) else {
            completion(.failure(GeoserverError.invalidUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(userAndPass)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            
            let parser = WMSCapabilitiesParser()
            if let wmsCapabilities = parser.parse(data: data) {
                completion(.success(wmsCapabilities))
            } else {
                completion(.failure(error!))
            }
        }.resume()
    }
}
