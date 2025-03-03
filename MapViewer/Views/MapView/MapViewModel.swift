//
//  MapViewModel.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-03-01.
//

import Foundation

class MapViewModel: ObservableObject {
    
    var enabledLayers: [Layer] = []
    
    func refreshMap() {
        print(enabledLayers.count)
    }
    
    func start() {
    }
}
