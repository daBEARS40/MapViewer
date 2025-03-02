//
//  WMSCapabilitiesParser.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//
//  Apple Docs on XMLParserDelegate: https://developer.apple.com/documentation/foundation/xmlparserdelegate
//
//  Another useful link: https://blog.logrocket.com/xml-parsing-swift/
//

import ObjectiveC
import Foundation

class WMSCapabilitiesParser: NSObject, XMLParserDelegate {
    
    private let parser: XMLParser
    private var stack = [XMLNode]()
    private var tree: XMLNode?

    init(data: Data) {
        parser = XMLParser(data: data)
        super.init()
        parser.delegate = self
    }

    func parse() -> XMLNode? {
        parser.parse()

        guard parser.parserError == nil else {
            return nil
        }

        return tree
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {
        let node = XMLNode(tag: elementName, data: "", attributes: attributeDict, childNodes: [])
        stack.append(node)
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        let lastElement = stack.removeLast()

        if let last = stack.last {
            last.childNodes += [lastElement]
        } else {
            tree = lastElement
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred: any Error) {
        print("Parse error at line: \(parser.lineNumber). Aborting.")
        parser.abortParsing()
    }


    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if (string.trimmingCharacters(in: .whitespacesAndNewlines) != "") {
            stack.last?.data = string
        }
    }
}
