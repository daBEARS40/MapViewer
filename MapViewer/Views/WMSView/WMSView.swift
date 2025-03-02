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
        LazyVStack {
            ForEach(viewModel.mapServices) { wms in
                Text(wms.name)
            }
        }
    }
}

#Preview {
    WMSView(viewModel: WMSViewModel())
}
