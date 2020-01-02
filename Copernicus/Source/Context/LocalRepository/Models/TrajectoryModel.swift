//
//  TrajectoryModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 02/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RealmSwift

public class TrajectoryModel: Object, Codable {
    
    //
    // MARK: - Properties
    //
    
    @objc dynamic var id: Int = 0
    @objc dynamic var geometry: GeometryModel?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case geometry
    }
    //
    // MARK: - Init
    //
    
    required public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        geometry = try? container.decodeIfPresent(GeometryModel.self, forKey: .geometry)
        
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
