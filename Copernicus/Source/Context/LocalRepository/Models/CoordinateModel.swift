//
//  CoordinateModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 02/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RealmSwift

public class CoordinateModel: Object, Codable {
    
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    
    init(latitude: Double? = 0.0, longitude: Double? = 0.0) {
        
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
}
