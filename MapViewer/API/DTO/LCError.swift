//
//  LCError.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//

import Foundation
enum GeoserverError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
}
