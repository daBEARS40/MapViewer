//
//  WMSDetailView.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-03-01.
//

import SwiftUI

struct WMSDetailView: View {
    
    let mapService: MapService
    
    var body: some View {
        VStack {
            WMSDetailViewItem(labelName: "Name", value: mapService.name)
            WMSDetailViewItem(labelName: "URL", value: mapService.url)
            WMSDetailViewItem(labelName: "Username", value: mapService.user)
            WMSDetailViewItem(labelName: "Password", value: mapService.pass)
        }
    }
}

#Preview {
    WMSDetailView(mapService: MapService(name: "North Vancouver", url: "https://geoserver-pr2.i-opentech.com/geoserver/NorthVancouver/wms", user: "rarmstrong", pass: "Fr33f00d"))
}
