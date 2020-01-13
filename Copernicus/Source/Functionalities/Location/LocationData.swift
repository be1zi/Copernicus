//
//  LocationData.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 03/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

public enum LocationType: Int {
    case Default = 0
    case Temporary
}

public struct LocationData {
    
    //
    // MARK: - Properties
    //
    
    public var country: String?
    public var city: String?
    public var street: String?
    public var houseNumber: String?
    public var zipCode: String?
    public var type: LocationType
    public var latitude: Double?
    public var longitude: Double?
    public var useMyLocation: Bool = false
    
    //
    // MARK: - Init
    //
    
    public init(type: LocationType = .Default) {
        self.type = type
    }
}
