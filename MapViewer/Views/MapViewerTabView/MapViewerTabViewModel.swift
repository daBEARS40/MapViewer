//
//  MapViewTabViewModel.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//

import SwiftUI

final class MapViewerTabViewModel: ObservableObject {
    var title: String = "Map"
    var wmsList: [WMSData] = []
}
