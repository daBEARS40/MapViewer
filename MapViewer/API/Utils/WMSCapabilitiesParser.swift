//
//  WMSCapabilitiesParser.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//

import ObjectiveC
import Foundation

class WMSCapabilitiesParser: NSObject, XMLParserDelegate {
    
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
            print(elementName)
        }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("Parsing finished.")
        print("Line number: \(parser.lineNumber)")
    }
}
