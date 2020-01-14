//
//  ImageryModel.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 14/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RealmSwift

public class ImageryModel: Object, Codable {
    
    //
    // MARK: - Properties
    //
    
    @objc dynamic var id: String = ""
    @objc dynamic var page: Int = 0
    @objc dynamic var next: String?
    let results = List<ImageryResultModel>()
    
    private enum CodingKeys: String, CodingKey {
        case id
        case page
        case next
        case results
    }
    
    //
    // MARK: - Init
    //
    
    required public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        page = try container.decodeIfPresent(Int.self, forKey: .page) ?? 0
        next = try? container.decodeIfPresent(String.self, forKey: .next)
        
        if let data = try? container.decodeIfPresent([ImageryResultModel].self, forKey: .results) {
            if results.count > 0 {
                results.removeAll()
            }
            
            results.append(objectsIn: data)
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
