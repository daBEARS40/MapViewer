//
//  WMSView.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-03-01.
//

import SwiftUI

struct WMSView: View {
    
    @ObservedObject var viewModel: WMSViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack() {
                    ForEach(viewModel.mapServices) { mapService in
                        NavigationLink(value: mapService) {
                            WMSLinkView(mapService: mapService)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Map Services")
            .navigationDestination(for: MapService.self) { mapService in
                WMSDetailView(mapService: mapService)
            }
        }
    }
}

#Preview {
    WMSView(viewModel: WMSViewModel())
}
