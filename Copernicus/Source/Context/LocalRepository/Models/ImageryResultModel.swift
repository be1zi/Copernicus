//
//  ImageryResultModel.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 14/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RealmSwift
import Foundation

public class ImageryResultModel: Object, Codable {
    
    //
    // MARK: - Properties
    //
    
    @objc dynamic var id: Int = 0
    @objc dynamic var uuid: String?
    @objc dynamic var identifier: String?
    @objc dynamic var ingestionDate: Date?
    @objc dynamic var beginPositionDate: Date?
    @objc dynamic var endPositionDate: Date?
    @objc dynamic var satellite: String?
    @objc dynamic var sceneId: String?
    @objc dynamic var cloudCoverPercentage: Double = 0.0
    @objc dynamic var productType: String?
    @objc dynamic var geometry: ImageryGeometryModel?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case uuid
        case identifier
        case ingestionDate = "ingestion_date"
        case beginPositionDate = "begin_position_date"
        case endPositionDate = "end_position_date"
        case satellite
        case sceneId = "scene_id"
        case cloudCoverPercentage = "cloud_cover_percentage"
        case productType = "product_type"
        case geometry
    }
    
    //
    // MARK: - Init
    //
    
    public required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        uuid = try? container.decodeIfPresent(String.self, forKey: .uuid)
        identifier = try? container.decodeIfPresent(String.self, forKey: .identifier)
       
        if let dateString = try? container.decodeIfPresent(String.self, forKey: .ingestionDate) {
            ingestionDate = DateFormatter.stringToDate(date: dateString)
        }
        
        if let dateString = try? container.decodeIfPresent(String.self, forKey: .beginPositionDate) {
            beginPositionDate = DateFormatter.stringToDate(date: dateString)
        }
        
        if let dateString = try? container.decodeIfPresent(String.self, forKey: .endPositionDate) {
            endPositionDate = DateFormatter.stringToDate(date: dateString)
        }
        
        satellite = try? container.decodeIfPresent(String.self, forKey: .satellite)
        sceneId = try? container.decodeIfPresent(String.self, forKey: .sceneId)
        
        if let cloudCoverString = try? container.decodeIfPresent(String.self, forKey: .cloudCoverPercentage),
            let cloudValue = Double(cloudCoverString) {
            cloudCoverPercentage = cloudValue
        }
        
        productType = try? container.decodeIfPresent(String.self, forKey: .productType)
        geometry = try? container.decodeIfPresent(ImageryGeometryModel.self, forKey: .geometry)
        //TODO: fix
        geometry?.id = id
        
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
