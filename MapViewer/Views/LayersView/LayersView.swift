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
                OutlineGroup(viewModel.layerList, id: \.id, children: \.children) { layer in
                    HStack {
                        ToggleButton(isEnabled: layer.readable == 1)
                        
                        Text(layer.title)
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Layers")
        }
    }
}

struct ToggleButton: View {
    @State var isEnabled: Bool

    var body: some View {
        Button(action: { isEnabled.toggle() }) {
            Circle()
                .fill(isEnabled ? Color.blue : Color.gray)
                .frame(width: 16, height: 16)
        }
        .buttonStyle(BorderlessButtonStyle()) // Prevents row selection when clicking the button
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
