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
    
    @objc dynamic var id: String = ""
    @objc dynamic var type: String?
    @objc dynamic var avg_footprint_width: Double = 0.0
    
    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case avg_footprint_width
    }
    
    //
    // MARK: - Init
    //
    
    required public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        type = try? container.decodeIfPresent(String.self, forKey: .type)
        avg_footprint_width = 1.0 //try container.decodeIfPresent(Double.self, forKey: .avg_footprint_width) ?? 0.0
        
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
