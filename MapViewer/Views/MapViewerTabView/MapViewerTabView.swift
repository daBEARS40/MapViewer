//
//  ContentView.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//

import SwiftUI

struct MapViewerTabView: View {
    
    @StateObject var viewModel = MapViewerTabViewModel()
    
    var body: some View {
        TabView {
            MapView(viewModel: viewModel.mapViewModel)
            .tabItem {
                Label("Map", systemImage: "map")
            }
            LayersView(viewModel: viewModel.layersViewModel)
            .tabItem {
                Label("Layers", systemImage: "square.2.layers.3d.fill")
            }
            WMSView(viewModel: viewModel.wmsViewModel)
            .tabItem {
                Label("WMS", systemImage: "square.and.pencil")
            }
        }
        .task {
            do {
                try viewModel.initMapViewer()
            } catch {
                print("Error")
            }
        }
    }
}

#Preview {
    MapViewerTabView()
}
