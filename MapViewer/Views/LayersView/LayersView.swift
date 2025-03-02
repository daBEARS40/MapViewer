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
        LazyVStack {
            ForEach(viewModel.layerList) { layer in
                Text(layer.title)
            }
        }
    }
}

#Preview {
    LayersView(viewModel: LayersViewModel())
}
