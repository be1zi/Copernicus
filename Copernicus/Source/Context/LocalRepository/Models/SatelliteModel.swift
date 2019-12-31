//
//  SatelliteModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 30/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import RealmSwift

public class SatelliteModel: Object, Codable {
    
    //
    // MARK: - Properties
    //
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var geometry: GeometryModel?
    //@objc dynamic var sensors: [SensorModel]?
    @objc dynamic var open: Bool = true
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case geometry
        //case sensors
        case open
    }
    
    //
    // MARK: - Init
    //
    
    required public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        geometry = try? container.decodeIfPresent(GeometryModel.self, forKey: .geometry)
        name = try? container.decodeIfPresent(String.self, forKey: .name)
        open = try container.decodeIfPresent(Bool.self, forKey: .open) ?? true
        
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
