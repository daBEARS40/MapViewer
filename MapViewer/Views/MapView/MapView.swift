//
//  MapView.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-03-01.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @ObservedObject var viewModel: MapViewModel
    
    var body: some View {
        Map {
            
        }
    }
}

#Preview {
    MapView(viewModel: MapViewModel())
}
