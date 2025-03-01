//
//  MapViewerApp.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//

import SwiftUI

@main
struct MapViewerApp: App {
    var body: some Scene {
        WindowGroup {
            MapViewerTabView(service: GeoserverService())
        }
    }
}
