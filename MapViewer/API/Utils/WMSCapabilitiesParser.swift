//
//  WMSCapabilitiesParser.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//
//  Apple Docs on XMLParserDelegate: https://developer.apple.com/documentation/foundation/xmlparserdelegate

import ObjectiveC
import Foundation

class WMSCapabilitiesParser: NSObject, XMLParserDelegate {
    
    var stack: [LayerDTO] = []
    var rootLayer: LayerDTO = LayerDTO()
    var currentLayer: LayerDTO = LayerDTO()
    
    func parserDidStartDocument(_ parser: XMLParser) {
        print("Parsing Started.")
        print("Line number: \(parser.lineNumber)")
    }
    
    func parser(
            _ parser: XMLParser,
            didStartElement elementName: String,
            namespaceURI: String?,
            qualifiedName qName: String?,
            attributes attributeDict: [String : String] = [:]
        ) {
            if (elementName == "Layer") {
                print("starting \(elementName)")
            }
        }
    
    func parser(
            _ parser: XMLParser,
            foundCharacters string: String
        ) {
            if (string.trimmingCharacters(in: .whitespacesAndNewlines) != "") {
                print(string)
            }
        }
    
    func parser(
            _ parser: XMLParser,
            didEndElement elementName: String,
            namespaceURI: String?,
            qualifiedName qName: String?
        ) {
            if (elementName == "Layer") {
                print("ending \(elementName)")
            }
        }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("Parsing finished.")
        print("Line number: \(parser.lineNumber)")
    }
}
