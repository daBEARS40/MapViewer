//
//  WMSCapabilitiesParser.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//

import ObjectiveC
import Foundation

class WMSCapabilitiesParser: NSObject, XMLParserDelegate {
    var wmsData: wmsData?
        var currentLayer: LayerDTO?
        var currentBoundingBox: BoundingBoxDTO?
        var currentElement: String = ""
        
        var version: String = ""
        var capability: CapabilityDTO?
        var layers: [LayerDTO] = []
        var boundingBoxes: [BoundingBoxDTO] = []
        var crsList: [String] = []
        
        func parse(data: Data) -> wmsData? {
            let parser = XMLParser(data: data)
            parser.delegate = self
            if parser.parse() {
                return MapViewer.wmsData(version: version, Capability: capability!)
            }
            return nil
        }
        
        // MARK: - XMLParser Delegate Methods
        
        func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {
            currentElement = elementName
            
            if elementName == "WMS_Capabilities" {
                version = attributeDict["version"] ?? "unknown"
            } else if elementName == "Layer" {
                currentLayer = LayerDTO(Abstract: "", BoundingBox: [], CRS: [], EX_GeographicBoundingBox: [], Title: "", Layer: [], Attribution: "")
            } else if elementName == "BoundingBox" {
                if let crs = attributeDict["CRS"],
                   let minx = attributeDict["minx"], let miny = attributeDict["miny"],
                   let maxx = attributeDict["maxx"], let maxy = attributeDict["maxy"] {

                    let extent = [Int(minx) ?? 0, Int(miny) ?? 0, Int(maxx) ?? 0, Int(maxy) ?? 0]
                    let res = [
                        Int(attributeDict["resx"] ?? "0") ?? 0,
                        Int(attributeDict["resy"] ?? "0") ?? 0
                    ]

                    currentBoundingBox = BoundingBoxDTO(crs: crs, extent: extent, res: res)
                }
            } else if elementName == "CRS" {
                crsList.append("")
            }
        }
        
        func parser(_ parser: XMLParser, foundCharacters string: String) {
            let trimmedString = string.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if !trimmedString.isEmpty {
                switch currentElement {
                case "Title":
                    currentLayer?.Title += trimmedString
                case "Abstract":
                    currentLayer?.Abstract += trimmedString
                case "Attribution":
                    currentLayer?.Attribution += trimmedString
                case "CRS":
                    crsList[crsList.count - 1] = trimmedString
                default:
                    break
                }
            }
        }
        
        func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
            if elementName == "Layer", let finishedLayer = currentLayer {
                layers.append(finishedLayer)
                currentLayer = nil
            } else if elementName == "BoundingBox", let finishedBoundingBox = currentBoundingBox {
                boundingBoxes.append(finishedBoundingBox)
                currentBoundingBox = nil
            } else if elementName == "CRS" {
                currentLayer?.CRS = crsList
            }
        }
        
        func parserDidEndDocument(_ parser: XMLParser) {
            capability = CapabilityDTO(Layer: layers.first ?? LayerDTO(Abstract: "", BoundingBox: [], CRS: [], EX_GeographicBoundingBox: [], Title: "", Layer: [], Attribution: ""))
        }
}
