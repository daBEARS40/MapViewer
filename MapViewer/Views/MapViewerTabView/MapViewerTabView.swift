//
//  ContentView.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//

import SwiftUI
import MapKit

struct MapViewerTabView: View {
    
    @StateObject var viewModel = MapViewerTabViewModel()
    
    var body: some View {
        TabView {
            Map {
                
            }
            .tabItem {
                Label("Map", systemImage: "map")
            }
            LazyVStack {
                
            }
            .tabItem {
                Label("Layers", systemImage: "square.2.layers.3d.fill")
            }
            LazyVStack {
                ForEach(MockData.wmsList) { wms in
                    Text(wms.name)
                    
                }
            }
            .tabItem {
                Label("WMS", systemImage: "square.and.pencil")
            }
        }
    }
}

#Preview {
    MapViewerTabView()
}
