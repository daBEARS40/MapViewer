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
    @State private var data: LayerDTO?
    var service: GeoserverService
    
    var body: some View {
        TabView {
            Map {
                
            }
            .tabItem {
                Label("Map", systemImage: "map")
            }
            LazyVStack {
                Button(action: {
                    Task {
                        try await getLayerDetails()
                    }
                }) {
                    Label("button", systemImage: "arrow.up")
                }
                
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
    
    func getLayerDetails() async throws {
        do {
            data = try await service.getLayerCapability()
        } catch GeoserverError.invalidUrl {
            print("Invalid URL")
        } catch GeoserverError.invalidResponse {
            print("Invalid Response")
        } catch GeoserverError.invalidData {
            print("Invalid Data")
        } catch {
            print("Unexpected Error")
        }
    }
}

#Preview {
    MapViewerTabView(service: GeoserverService())
}
