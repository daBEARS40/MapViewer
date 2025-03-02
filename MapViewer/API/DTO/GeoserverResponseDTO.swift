//
//  LayerCapabilityDTO.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//

struct GeoserverResponseDTO: Decodable {
    var grp: Int
    var idx: Int
    var pass: String
    var user: String
    var url: String
    var wmsData: wmsData
}
