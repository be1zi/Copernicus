//
//  OverpassModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 04/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RealmSwift

public class OverpassModel: Object, Codable {
    
    //
    // MARK: - Properties
    //
    
    @objc dynamic var id: Int = 0
    @objc dynamic var frequency: Int = 0
    let overpasses = List<SingleOverpassModel>()
    
    private enum CodingKeys: String, CodingKey {
        case id
        case frequency
        case overpasses
    }
    
    //
    // MARK: - Init
    //
    
    public required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        frequency = try container.decodeIfPresent(Int.self, forKey: .frequency) ?? 0
        
        if let data = try? container.decodeIfPresent([SingleOverpassModel].self, forKey: .overpasses) {
            if overpasses.count > 0 {
                overpasses.removeAll()
            }
            
            overpasses.append(objectsIn: data)
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
