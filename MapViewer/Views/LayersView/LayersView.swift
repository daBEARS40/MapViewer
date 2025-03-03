//
//  LayersView.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-03-01.
//

import SwiftUI

struct LayersView: View {
    
    @ObservedObject var viewModel: LayersViewModel
    
    var body: some View {
        NavigationStack {
            List {
                //viewModel.layerListPreview
                OutlineGroup(viewModel.layerList, id: \.id, children: \.children) { subLayer in
                    Text(subLayer.title).font(.subheadline)
                }
                .listStyle(SidebarListStyle())
            }
            .navigationTitle("Layers")
        }
    }
}

#Preview {
    LayersView(viewModel: LayersViewModel(layerListPreview: [
        Layer(title: "North Vancouver WMS", children: [
            Layer(title: "North Vancouver Land", children: []),
            Layer(title: "North Vancouver Water", children: [])
        ]),
        Layer(title: "City of Pitt Meadows", children: [
            Layer(title: "City of Pitt Meadows Land", children: []),
            Layer(title: "City of Pitt Meadows Water", children: [])
        ])
    ]))
}

//ForEach(viewModel.layerList, id: \.id) { layer in

//            List {
//                OutlineGroup(viewModel.layerListPreview, id: \.id, children: \.children) { layer in
//                        Text(layer.title).font(.subheadline)
//                    }.listStyle(SidebarListStyle())
//            }.listStyle(SidebarListStyle())
