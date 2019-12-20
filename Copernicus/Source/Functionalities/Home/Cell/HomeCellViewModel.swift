//
//  HomeCellModel.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 17/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import UIKit

public struct HomeCellViewModel {
    
    //
    // MARK: - Properties
    //
    
    public let title: String
    public let image: UIImage?
    public let storyboardName: String?
    
    //
    // MARK: - Init
    //
    
    public init(title: String, imageName: String? = nil, storyboardName: String? = nil) {
        self.title = title
        self.storyboardName = storyboardName
        
        if let imageName = imageName {
            self.image = UIImage(named: imageName)
        } else {
            self.image = nil
        }
    }
}
