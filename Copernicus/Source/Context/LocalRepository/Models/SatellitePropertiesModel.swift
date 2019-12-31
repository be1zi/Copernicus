//
//  SatellitePropertiesModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 31/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import RealmSwift

public class SatellitePropertiesModel: Object, Codable {
    
    //
    // MARK: - Properties
    //
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var norad_id: Int = 0
    @objc dynamic var open: Bool = false
    @objc dynamic var platform: String?
    let sensors = List<SensorModel>()

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case norad_id
        case open
        case platform
        case sensors
    }
    
    //
    // MARK: - Init
    //
    
    required public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try? container.decodeIfPresent(String.self, forKey: .name)
        norad_id = try container.decodeIfPresent(Int.self, forKey: .norad_id) ?? 0
        open = try container.decodeIfPresent(Bool.self, forKey: .open) ?? false
        platform = try? container.decodeIfPresent(String.self, forKey: .platform)
        
        if let data = try? container.decodeIfPresent([SensorModel].self, forKey: .sensors) {
            if sensors.count > 0 {
                sensors.removeAll()
            }
            
            sensors.append(objectsIn: data)
        }
        
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
}

