//
//  LocationManager.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 13/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import CoreLocation
import MapKit

public struct LocationRegion {
    
    public let latMin: Double
    public let latMax: Double
    public let longMin: Double
    public let longMax: Double

    public init(latMin: Double, latMax: Double, longMin: Double, longMax: Double) {
        self.latMin = latMin
        self.latMax = latMax
        self.longMin = longMin
        self.longMax = longMax
    }
    
    public func toString() -> String {
        return "\(latMin),\(longMin),\(latMax),\(longMax)"
    }
}

public struct LocationManager {
    
    //
    // MARK: - Singleton
    //
    
    static let sharedInstance = LocationManager()
    
    //
    // MARK: - Properties
    //
    
    private let meters: CLLocationDistance = 2000
    
    //
    // MARK: - Methods
    //
    
    public func createBoundingBox(center: CLLocationCoordinate2D) -> LocationRegion {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: meters, longitudinalMeters: meters)
        
        let latMin = region.center.latitude - 0.5 * region.span.latitudeDelta
        let latMax = region.center.latitude + 0.5 * region.span.latitudeDelta
        let longMin = region.center.longitude - 0.5 * region.span.longitudeDelta
        let longMax = region.center.longitude + 0.5 * region.span.longitudeDelta
        
        return LocationRegion(latMin: latMin, latMax: latMax, longMin: longMin, longMax: longMax)
    }
}
