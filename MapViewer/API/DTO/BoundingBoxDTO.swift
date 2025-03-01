//
//  BoundingBoxDTO.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//

struct BoundingBoxDTO: Decodable {
    var crs: String? = nil
    var extent: extentObject? = nil
}

struct extentObject: Decodable {
    var minx: Float? = nil
    var miny: Float? = nil
    var maxx: Float? = nil
    var maxy: Float? = nil
}
