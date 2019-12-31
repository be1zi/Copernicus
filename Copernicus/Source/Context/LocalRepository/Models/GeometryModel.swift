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
    let coordinates = List<Double>()
    
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
        
        if let coord = try? container.decodeIfPresent([Double].self, forKey: .coordinates) {
            if coordinates.count != 0 {
                coordinates.removeAll()
            }
            
            coordinates.append(objectsIn: coord)
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
