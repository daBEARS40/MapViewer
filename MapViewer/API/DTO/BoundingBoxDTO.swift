//
//  BoundingBoxDTO.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//

struct BoundingBoxDTO: Decodable {
    var crs: String
    var extent: [Int]
    var res: [Int]
}
