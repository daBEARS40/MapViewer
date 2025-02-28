//
//  WMSData.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//

import Foundation

struct WMSData: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let url: String
    let user: String
    let pass: String
}

struct MockData {
    static let wmsList = [
        WMSData(name: "North Vancouver", url: "https://www.google.ca", user: "username", pass:"pass"),
        WMSData(name: "Agrilyze Shared", url: "https://www.google.ca", user: "username", pass:"pass"),
        WMSData(name: "Midwest Surveys", url: "https://www.google.ca", user: "username", pass:"pass"),
    ]
}
