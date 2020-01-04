//
//  SingleOverpassModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 04/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RealmSwift

public class SingleOverpassModel: Object, Codable {
 
    //
    // MARK: - Properties
    //
    
    @objc dynamic var id: Int = 0
    @objc dynamic var satellite: String?
    @objc dynamic var date: String?
    @objc dynamic var acquisition: Bool = false
    @objc dynamic var geometry: OverpassGeometryModel?
    @objc dynamic var footprint: OverpassFootprintModel?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case satellite
        case date
        case acquisition
        case geometry
        case footprint
    }
    
    //
    // MARK: - Init
    //
    
    required public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        satellite = try? container.decodeIfPresent(String.self, forKey: .satellite)
        date = try? container.decodeIfPresent(String.self, forKey: .date)
        acquisition = try container.decodeIfPresent(Bool.self, forKey: .acquisition) ?? false
        geometry = try? container.decodeIfPresent(OverpassGeometryModel.self, forKey: .geometry)
        footprint = try? container.decodeIfPresent(OverpassFootprintModel.self, forKey: .footprint)
        
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
