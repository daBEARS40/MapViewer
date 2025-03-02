//
//  WMSDetailViewItem.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-03-01.
//

import SwiftUI

struct WMSDetailViewItem: View {
    
    let labelName: String
    let value: String
    
    var body: some View {
        HStack() {
            Label("\(labelName):", systemImage: "")
                .frame(width: 100)
            ScrollView(.horizontal) {
                Text(value)
                    .padding()
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    WMSDetailViewItem(labelName: "Name", value: "North Vancouver WMS")
}
