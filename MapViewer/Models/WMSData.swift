//
//  wmsData.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//

struct WMSData {
    let node: XMLNode
    let url: String
    let user: String
    let pass: String
    var root: String

    init(node: XMLNode, url: String, user: String, pass: String, root: String) {
        self.node = node
        self.url = url
        self.user = user
        self.pass = pass
        self.root = root
    }
}
