//
//  MapViewTabViewModel.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//

import SwiftUI

@MainActor
final class MapViewerTabViewModel: ObservableObject {

    @Published var layersViewModel = LayersViewModel(layerListPreview: [])
    @Published var wmsViewModel = WMSViewModel()
    @Published var mapViewModel = MapViewModel()
    
    func initMapViewer() async throws {
        wmsViewModel.start()
        try await layersViewModel.start(mapServices: wmsViewModel.mapServices)
        mapViewModel.start()
    }
    
}
