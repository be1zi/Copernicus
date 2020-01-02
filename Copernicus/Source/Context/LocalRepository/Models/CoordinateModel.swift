//
//  CoordinateModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 02/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RealmSwift

public class CoordinateModel: Object, Codable {
    
    @objc dynamic var id: String = ""
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    
    init(id: String, latitude: Double? = 0.0, longitude: Double? = 0.0) {
        self.id = id
        
        if let lat = latitude {
            self.latitude = lat
        }
        
        if let long = longitude {
            self.longitude = long
        }
    }
    
    required init() {
        super.init()
    }
    
    public override class func primaryKey() -> String? {
        return "id"
    }
}
