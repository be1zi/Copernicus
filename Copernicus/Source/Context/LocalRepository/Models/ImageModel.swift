//
//  ImageModel.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 20/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import Foundation
import RealmSwift

public class ImageModel: Object, Codable {
    
    //
    // MARK: - Properties
    //
    
    @objc dynamic var id: String = ""
    @objc dynamic var path: String?
    @objc dynamic var name: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case path
        case name
    }
    
    //
    // MARK: - Init
    //
    
    required public init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        path = try? container.decodeIfPresent(String.self, forKey: .path)
        name = try? container.decodeIfPresent(String.self, forKey: .name)
        
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
