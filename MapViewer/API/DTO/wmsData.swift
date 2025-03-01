//
//  wmsData.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//

struct wmsData: Decodable {
    var version: String? = nil
    var Capability: CapabilityDTO? = nil
}
