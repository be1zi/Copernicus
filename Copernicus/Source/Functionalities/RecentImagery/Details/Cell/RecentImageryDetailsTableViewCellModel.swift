//
//  RecentImageryDetailsTableViewCellModel.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 20/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import Foundation

public struct RecentImageryDetailsTableViewCellModel {
    
    //
    // MARK: - Properties
    //
    
    private let imageModel: ImageModel
    public var imageURL: URL?
    public var basePath: String?
    
    //
    // MARK: - Init
    //
    
    public init(model: ImageModel, basePath: String?) {
        self.imageModel = model
        self.basePath = basePath
        self.setImageUrl()
    }
    
    private mutating func setImageUrl() {

        guard let base = basePath,
            let path = imageModel.path,
            let apiKey = ConfigurationManager.sharedInstance.serverKey else { return }
        
        
        let urlString = "\(base)\(path)?api_key=\(apiKey)"
        self.imageURL = URL(string: urlString)
    }
}
