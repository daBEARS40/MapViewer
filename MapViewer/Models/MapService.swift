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
}

struct MockData {
    static let wmsList = [
        MapService(name: "North Vancouver", url: "https://www.google.ca", user: "username", pass:"pass"),
        MapService(name: "Agrilyze Shared", url: "https://www.google.ca", user: "username", pass:"pass"),
        MapService(name: "Midwest Surveys", url: "https://www.google.ca", user: "username", pass:"pass"),
    ]
}
