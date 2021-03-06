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
    @objc dynamic var geometry: SingleGeometryModel?
    @objc dynamic var properties: SatellitePropertiesModel?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case geometry
        case properties
    }
    
    //
    // MARK: - Init
    //
    
    required public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        geometry = try? container.decodeIfPresent(SingleGeometryModel.self, forKey: .geometry)
        properties = try? container.decodeIfPresent(SatellitePropertiesModel.self, forKey: .properties)
        
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
