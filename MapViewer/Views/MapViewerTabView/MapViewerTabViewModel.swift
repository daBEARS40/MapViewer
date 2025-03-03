//
//  MapViewTabViewModel.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//

import SwiftUI
import Observation

@MainActor
@Observable final class MapViewerTabViewModel {

    var wmsViewModel = WMSViewModel()
    var mapViewModel = MapViewModel()
    var layersViewModel = LayersViewModel(layerListPreview: [])
    
    func initMapViewer() throws {
        wmsViewModel.start()
        mapViewModel.start()
        try layersViewModel.start(mapServices: wmsViewModel.mapServices, mapViewModel: mapViewModel)
    }
    
}
