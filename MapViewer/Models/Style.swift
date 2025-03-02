//
//  Style.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-03-01.
//

struct Style {
    var name: String
    var title: String
    var legendURL: [LegendURL]
    
    init() {
        self.name = ""
        self.title = ""
        self.legendURL = []
    }
    
    init(name: String, title: String, legendURL: [LegendURL]) {
        self.name = name
        self.title = title
        self.legendURL = legendURL
    }
}
