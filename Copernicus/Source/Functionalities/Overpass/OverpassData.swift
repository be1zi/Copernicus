//
//  OverpassData.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 04/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

public struct OverpassData {
    
    //
    // MARK: - Properties
    //
    
    public var latitude1: Double = 19.59
    public var longitude1: Double = 49.90
    public var latitude2: Double = 20.33
    public var longitude2: Double = 50.21
    private let satellites: [String]

    //
    // MARK: - Init
    //
    
    public init() {
        self.satellites = ["Sentinel-2A", "Sentinel-2B", "Landsat-8"]
    }
    
    //
    // MARK: - Methods
    //
    
    public func geometryString() -> String {
        return "\(latitude1),\(longitude1),\(latitude2),\(longitude2)"
    }
    
    public func satellitesString() -> String {
        var value = ""
        
        for (index, element) in satellites.enumerated() {
            if index == (satellites.count - 1) {
                value += element
            } else {
                value += "\(element),"

            }
        }
        
        return value
    }
}