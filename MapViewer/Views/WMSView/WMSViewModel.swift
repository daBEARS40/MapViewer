//
//  WMSViewModel.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-03-01.
//

import Foundation

class WMSViewModel: ObservableObject {
    
    //@Published var mapServices: [MapService] = []
    @Published var mapServices = [
        MapService(name: "North Vancouver WMS", url: "https://geoserver-pr2.i-opentech.com/geoserver/NorthVancouver/wms", user: "rarmstrong", pass: "Fr33f00d"),
        MapService(name: "City of Pitt Meadows", url: "https://geoserver-st.i-opentech.com/geoserver/PittMeadows/wms", user: "llevesque", pass: "Kenneth-0803"),
        MapService(name: "Soil Data WMS", url: "https://geo-autoag.i-opentech.com/geoserver/SoilData/wms", user: "rarmstrong", pass: "Fr33f00d")
    ]
    
    let service: GeoserverService = GeoserverService()
    
    func getMapServices() {
        mapServices = service.getMapServices()
    }
    
    func start() {
        getMapServices()
        print("WMSView Model Started!")
    }
}
