//
//  Layer.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//

class Layer {
    var title: String
    var name: String
    var keywords: [String]
    var crs: [String]
    var attribution: String
    var visible: Int
    var readable: Int
    var writeable: Int
    var searchable: Int
    var selectable: Int
    var legend: Int
    var opacity: Double
    var minScale: Int
    var maxScale: Int
    var url: String
    var user: String
    var pass: String
    var geoserverSrs: String
    var extent: [Double]
    var defaultOn: Bool
    var type: String
    var styles: [Style]
    var parent: Layer?
    var children: [Layer]
    
    init() {
        self.title = ""
        self.name = ""
        self.keywords = []
        self.crs = []
        self.attribution = ""
        self.visible = 0
        self.readable = 0
        self.writeable = 0
        self.searchable = 0
        self.selectable = 0
        self.legend = 0
        self.opacity = 1.0
        self.minScale = 0
        self.maxScale = 24
        self.url = ""
        self.user = ""
        self.pass = ""
        self.geoserverSrs = ""
        self.extent = []
        self.defaultOn = false
        self.type = ""
        self.styles = []
        self.parent = nil
        self.children = []
    }
    
    init(title: String, name: String, keywords: [String], crs: [String], attribution: String, visible: Int, readable: Int, writeable: Int, searchable: Int, selectable: Int, legend: Int, opacity: Double, minScale: Int, maxScale: Int, url: String, user: String, pass: String, geoserverSrs: String, extent: [Double], defaultOn: Bool, type: String, styles: [Style], parent: Layer, children: [Layer]) {
        self.title = title
        self.name = name
        self.keywords = keywords
        self.crs = crs
        self.attribution = attribution
        self.visible = visible
        self.readable = readable
        self.writeable = writeable
        self.searchable = searchable
        self.selectable = selectable
        self.legend = legend
        self.opacity = opacity
        self.minScale = minScale
        self.maxScale = maxScale
        self.url = url
        self.user = user
        self.pass = pass
        self.geoserverSrs = geoserverSrs
        self.extent = extent
        self.defaultOn = defaultOn
        self.type = type
        self.styles = styles
        self.parent = parent
        self.children = children
    }
}
