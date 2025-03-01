//
//  WMSCapabilitiesParser.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-02-28.
//

import ObjectiveC
import Foundation

class WMSCapabilitiesParser: NSObject, XMLParserDelegate {
    
//    var hierarchy = wmsData()
//    var capability = CapabilityDTO()
//    var currentVersion: String = ""
    
      var currentLayer = LayerDTO()
      var currentCrsList: [String] = []
      var currentEXBoundingBox: [Float] = []
      var currentBoundingBox: [BoundingBoxDTO] = []
    
    
    private var stack: [LayerDTO] = []
    var rootLayer: LayerDTO?
    
    func parse(xmlData: Data) -> LayerDTO? {
        let parser = XMLParser(data: xmlData)
        parser.delegate = self
        if parser.parse() {
            return rootLayer
        } else {
            return nil
        }
    }
    
    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName: String?,
                foundCharacters string: String,
                attributes attributeDict: [String : String] = [:]
    ) {
        if (elementName == "Layer") {
            currentLayer = LayerDTO()
        }
        
        if (elementName == "Title") {
            if (string.trimmingCharacters(in: .whitespacesAndNewlines) != "") {
                currentLayer.Title = string
            }
        }

        if (elementName == "CRS") {
            if (string.trimmingCharacters(in: .whitespacesAndNewlines) != "") {
                currentCrsList.append(string)
            }
        }

        if (elementName == "westBoundLongitude" || elementName == "eastBoundLongitude" || elementName == "southBoundLongitude" || elementName == "northBoundLongitude") {
            if (string.trimmingCharacters(in: .whitespacesAndNewlines) != "") {
                currentEXBoundingBox.append(Float(string)!)
            }
        }

        if (elementName == "BoundingBox") {
        var bbox = BoundingBoxDTO()
        var extent = extentObject()

        for (attr_key, attr_val) in attributeDict {
            if (attr_key == "CRS") {
                bbox.crs = attr_val
            }
            switch attr_key {
            case "minx":
                extent.minx = Float(attr_val)
                break
            case "maxx":
                extent.maxx = Float(attr_val)
                break
            case "miny":
                extent.miny = Float(attr_val)
                break
            case "maxy":
                extent.maxy = Float(attr_val)
                break
            default:
                break
            }
        }
        bbox.extent = extent
        currentBoundingBox.append(bbox)
        }
        
        if var parentLayer = stack.last {
            parentLayer.Layer.append(currentLayer)
        } else {
            rootLayer = currentLayer
        }
        
        stack.append(currentLayer)
    }
    
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI nameSpaceURI: String?,
                qualifiedName: String?) {
        if (elementName == "Layer") {
            currentLayer = LayerDTO()
            currentCrsList = []
            currentBoundingBox = []
            currentEXBoundingBox = []
            _ = stack.popLast()
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("Parsing finished.")
        print("Line number: \(parser.lineNumber)")
    }
}


/*if (elementName == "WMS_Capability") {
hierarchy.version = attributeDict["version"] ?? "unknown"
}



if (elementName == "Layer") {
currentLayer = LayerDTO()
currentCrsList = []
currentEXBoundingBox = []
currentBoundingBox = []
}

if (elementName == "Title") {
if (string.trimmingCharacters(in: .whitespacesAndNewlines) != "") {
    currentLayer.Title = string
}
}

if (elementName == "CRS") {
if (string.trimmingCharacters(in: .whitespacesAndNewlines) != "") {
    currentCrsList.append(string)
}
}

if (elementName == "westBoundLongitude" || elementName == "eastBoundLongitude" || elementName == "southBoundLongitude" || elementName == "northBoundLongitude") {
if (string.trimmingCharacters(in: .whitespacesAndNewlines) != "") {
    currentEXBoundingBox.append(Float(string)!)
}
}

if (elementName == "BoundingBox") {
var bbox = BoundingBoxDTO()
var extent = extentObject()

for (attr_key, attr_val) in attributeDict {
    if (attr_key == "CRS") {
        bbox.crs = attr_val
    }
    switch attr_key {
    case "minx":
        extent.minx = Float(attr_val)
        break
    case "maxx":
        extent.maxx = Float(attr_val)
        break
    case "miny":
        extent.miny = Float(attr_val)
        break
    case "maxy":
        extent.maxy = Float(attr_val)
        break
    default:
        break
    }
}
bbox.extent = extent
currentBoundingBox.append(bbox)
}

currentLayer.Abstract = ""
currentLayer.Attribution = ""
currentLayer.BoundingBox = currentBoundingBox
currentLayer.CRS = currentCrsList
currentLayer.EX_GeographicBoundingBox = currentEXBoundingBox
capability.Layer = currentLayer
*/
