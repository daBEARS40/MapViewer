//
//  LayersViewModel.swift
//  MapViewer
//
//  Created by Lane Levesque on 2025-03-01.
//

import Foundation

@MainActor
class LayersViewModel: ObservableObject {
    
    @Published var layerList: [Layer] = []
    
    //Mock Data for Previews
    var layerListPreview: [Layer] = []
    init(layerListPreview: [Layer]) {
        self.layerListPreview = layerListPreview
    }
    //End Mock
    
    private var service = GeoserverService()
    
    func start(mapServices: [MapService]) throws {
        Task {
            do {
                try await self.populateLayerHierarchy(mapServices: mapServices)
            } catch {
                print("broke")
            }
        }
    }
    
    func populateLayerHierarchy(mapServices: [MapService]) async throws -> Void {
        let wmsList: [WMSData] = try await service.getAllCapabilitiesForWMSList(mapServices: mapServices)
    
        for var wms in wmsList {
            for node in wms.node.childNodes {
                if (node.tag == "Name") {
                    if (!node.data.contains(":")) {
                        wms.root = node.data
                    }
                }
            }
            layerList.append(buildLayerList(node: wms.node, wms: wms))
        }
    }
    
    func buildLayerList(node: XMLNode, wms: WMSData) -> Layer {
        let layer = Layer()
        
        layer.url = wms.url
        layer.user = wms.user
        layer.pass = wms.pass
        
        var minScale: Int = 0
        var crs: String = ""
        var styles: [Style] = []
        
        var childLayerNodes: [XMLNode] = []
        
        for childNode in node.childNodes {
            
            switch childNode.tag {
            case "Title":
                layer.title = childNode.data
                break
            case "Name":
                if (wms.root.isEmpty) {
                    layer.name = childNode.data
                } else {
                    layer.name = "\(wms.root):\(childNode.data)"
                }
                break
            case "KeywordList":
                if (childNode.data.isEmpty) {
                    layer.keywords = ["layerGroup", "layerContainer"]
                } else {
                    layer.keywords = getDataFromChildTags(node: childNode, tag: "Keyword")
                }
            case "MaxScaleDenominator":
                layer.maxScale = Int(childNode.data) ?? 25000000
                break
            case "MinScaleDenominator":
                minScale = Int(childNode.data) ?? 0
                break
            case "CRS":
                if (crs.isEmpty) {
                    crs = childNode.data
                }
                break
            case "Attribution":
                let attr = getDataFromChildTags(node: childNode, tag: "Attribution")
                if (attr.count > 0) {
                    layer.attribution = attr[0]
                }
            case "BoundingBox":
                if (childNode.getAttribute("CRS") == "EPSG:3857") {
                    var extent: [Double] = []
                    //TODO: why do i have to check both the return value of getAttribute AND the parsing into a Double? much to learn
                    extent.append(Double(childNode.getAttribute("minx") ?? "0.0") ?? 0.0)
                    extent.append(Double(childNode.getAttribute("minx") ?? "0.0") ?? 0.0)
                    extent.append(Double(childNode.getAttribute("minx") ?? "0.0") ?? 0.0)
                    extent.append(Double(childNode.getAttribute("minx") ?? "0.0") ?? 0.0)
                    layer.extent = extent
                }
                break
            case "Style":
                var shouldBreakOuterLoop: Bool = false
                var style: Style = Style()
                var legendURL: LegendURL = LegendURL()
                for subChildNode in childNode.childNodes {
                    switch subChildNode.tag {
                    case "Name":
                        if (subChildNode.data.contains("default-style")) {
                            shouldBreakOuterLoop = true
                            break
                        }
                        style.name = subChildNode.data
                        break
                    case "Title":
                        style.title = subChildNode.data
                        break
                    case "LegendURL":
                        var size: [Int] = []
                        //TODO: same question??
                        size.append(Int(subChildNode.getAttribute("width") ?? "20") ?? 20)
                        size.append(Int(subChildNode.getAttribute("height") ?? "20") ?? 20)
                        legendURL.size = size
                        
                        for subSubChildNode in subChildNode.childNodes {
                            switch subSubChildNode.tag {
                            case "OnlineResource":
                                legendURL.onlineResource = subSubChildNode.getAttribute("xlink:href") ?? ""
                                break
                            case "Format":
                                legendURL.format = subSubChildNode.data
                                break
                            default:
                                break
                            }
                        }
                        style.legendURL.append(legendURL)
                        styles.append(style)
                        break
                    default:
                        break
                    }
                    if (shouldBreakOuterLoop) {
                        break
                    }
                }
                
                break
            case "Layer":
                childLayerNodes.append(childNode)
                break
            default:
                break
            }
            
        }
        
        layer.minScale = minScale
        layer.geoserverSrs = crs
        layer.styles = styles
        
        if (childLayerNodes.count > 0) {
            layer.type = "LayerGroup"
            var children: [Layer] = []
            
            for childNode in childLayerNodes {
                children.append(buildLayerList(node: childNode, wms: wms))
            }
            
            if (children.count > 0) {
                children.reverse()
                layer.children = children
            }
        } else {
            layer.type = "Layer"
        }
        
        return layer
    }
    
    func getDataFromChildTags(node: XMLNode, tag: String) -> [String] {
        var data: [String] = []
        
        for childNode in node.childNodes {
            if (childNode.tag == tag) {
                data.append(childNode.data)
            }
        }
        
        return data
    }
    
}
