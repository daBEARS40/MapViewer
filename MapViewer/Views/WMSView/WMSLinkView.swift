//
//  WMSLinkView.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-03-01.
//

import SwiftUI

struct WMSLinkView: View {
    
    let mapService: MapService
    
    var body: some View {
        Label(mapService.name, systemImage: "")
            .font(.title2)
            .bold()
            
    }
}

#Preview {
    WMSLinkView(mapService: MapService(name: "North Vancouver", url: "https://geoserver-pr2.i-opentech.com/geoserver/NorthVancouver/wms", user: "rarmstrong", pass: "Fr33f00d"))
}
