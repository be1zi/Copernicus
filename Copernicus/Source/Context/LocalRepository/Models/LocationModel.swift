//
//  LocationModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 03/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RealmSwift

public class LocationModel: Object {
    
    //
    // MARK: - Properties
    //
    
    @objc dynamic var id: Int = 0
    @objc dynamic var country: String?
    @objc dynamic var city: String?
    @objc dynamic var street: String?
    @objc dynamic var houseNumber: String?
    @objc dynamic var zipCode: String?
    
    //
    // MARK: - Init
    //
    
    init(_ data: LocationData) {
        self.country = data.country
        self.city = data.city
        self.street = data.street
        self.houseNumber = data.houseNumber
        self.zipCode = data.zipCode
        
        super.init()
    }
    
    public required init() {
        super.init()
    }
    
    //
    // MARK: - Methods
    //
    
    public override class func primaryKey() -> String? {
        return "id"
    }
    
    public func exist() -> Bool {
        var exist = false
        
        if let country = self.country, !country.isEmpty {
            exist = true
        }
        
        if let city = self.city, !city.isEmpty {
            exist = true
        }
        
        if let zipCode = self.zipCode, !zipCode.isEmpty {
            exist = true
        }
        
        return exist
    }
    
    public func toString() -> String {
        var location = ""
        var emptyString = true
        
        if let value = self.country, !value.isEmpty {
            location += value
            emptyString = false
        }
        
        if let value = self.city, !value.isEmpty {
            if emptyString {
                location += value
            } else {
                location += ", \(value)"
            }
            
            emptyString = false
        }
        
        if let value = self.street, !value.isEmpty {
            if emptyString {
                location += value
            } else {
                location += ", \(value)"
            }
            
            emptyString = false
        }
        
        if let value = self.houseNumber, !value.isEmpty {
            if emptyString {
                location += value
            } else {
                location += ", \(value)"
            }
            
            emptyString = false
        }
        
        if let value = self.zipCode, !value.isEmpty {
            if emptyString {
                location += value
            } else {
                location += ", \(value)"
            }
            
            emptyString = false
        }
        
        return location
    }
}
