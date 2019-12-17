//
//  HomeCellModel.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 17/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import UIKit

struct HomeCellViewModel {
    
    //
    // MARK: - Properties
    //
    
    var title: String
    var image: UIImage?
    
    //
    // MARK: - Init
    //
    
    public init(title: String, imageName: String? = nil) {
        self.title = title
        
        if let imageName = imageName {
            self.image = UIImage(named: imageName)
        }
    }
}
