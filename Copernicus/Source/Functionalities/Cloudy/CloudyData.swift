//
//  CloudyData.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 14/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import CoreLocation

public struct CloudyData {
    
    //
    // MARK: - Properties
    //
    
    public var boundingBox: LocationRegion
    private let satellites: [String]
    private let dateFrom: Date
    
    //
    // MARK: - Init
    //
    
    public init(latitude: Double, longitude: Double) {
        self.boundingBox = LocationManager.sharedInstance.createBoundingBox(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        self.satellites = ["Sentinel-2A", "Sentinel-2B", "Landsat-8"]
        self.dateFrom = Seasons.dateYearAgo()
    }
    
    //
    // MARK: - Methods
    //
    
    public func geometryString() -> String {
        return boundingBox.toString()
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
    
    public func dateFromString() -> String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        
        return df.string(from: dateFrom)
    }
}
