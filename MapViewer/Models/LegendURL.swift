//
//  LegendURL.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-03-01.
//

struct LegendURL {
    var format: String
    var onlineResource: String
    var size: [Int]
    
    init() {
        self.format = ""
        self.onlineResource = ""
        self.size = []
    }
    
    init(format: String, onlineResource: String, size: [Int]) {
        self.format = format
        self.onlineResource = onlineResource
        self.size = size
    }
}
