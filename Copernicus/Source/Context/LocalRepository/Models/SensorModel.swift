//
//  SensorModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 30/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import RealmSwift

public class SensorModel: Object, Codable {
    
    //
    // MARK: - Properties
    //
    
    @objc dynamic var type: String?
    @objc dynamic var arvFootprintWidth: String?
}
