//
//  WMSViewModel.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-03-01.
//

import Foundation

class WMSViewModel: ObservableObject {
    
    @Published var mapServices: [MapService] = []
    
    let service: GeoserverService = GeoserverService()
    
    func getMapServices() {
        mapServices = service.getMapServices()
    }
    
    func start() {
        getMapServices()
    }
}
