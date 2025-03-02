//
//  WMSData.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//

import Foundation

struct MapService: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let url: String
    let user: String
    let pass: String
    
    init(name: String, url: String, user: String, pass: String) {
        self.name = name
        self.url = url
        self.user = user
        self.pass = pass
    }
}
