//
//  GeometryModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 30/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import RealmSwift

public class GeometryModel: Object, Codable {
    
    //
    // MARK: - Properties
    //
    
    @objc dynamic var id: Int = 0
    @objc dynamic var type: String?
    dynamic var coordinates: List<Double>?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case type
        case coordinates
    }
    
    //
    // MARK: - Init
    //
    
    required public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        type = try? container.decodeIfPresent(String.self, forKey: .type)
        coordinates = try? container.decodeIfPresent(List<Double>.self, forKey: .coordinates)
        
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
