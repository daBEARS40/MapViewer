//
//  MapViewModel.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-03-01.
//

import Foundation
import MapKit

class MapViewModel: ObservableObject {
    
    var enabledLayers: [Layer] = []
    
    func refreshMap() {
        //print(enabledLayers.count)
        var tileOverlays: [TileOverlay] = []
        for layer in enabledLayers {
            let tileOverlay = TileOverlay(urlTemplate: layer.url)
            tileOverlay.canReplaceMapContent = false
            tileOverlays.append(tileOverlay)
        }
        
    }
    
    func start() {
    }
}

class TileOverlay: MKTileOverlay {
    
}

class TORenderer: MKTileOverlayRenderer {
    
}
