//
//  LayerDTO.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//

struct LayerDTO: Decodable {
    var Abstract: String? = ""
    var BoundingBox: [BoundingBoxDTO]? = []
    var CRS: [String]? = []
    var EX_GeographicBoundingBox: [Float]? = nil
    var Title: String? = ""
    var Layer: [LayerDTO] = []
    var Attribution: String? = ""
}
