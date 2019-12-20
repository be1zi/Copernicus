//
//  WalkthroughContentViewModel.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 19/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import UIKit

public struct WalkthroughContentViewModel {

    //
    // MARK: - Properties
    //
    
    public var backgroundImage: UIImage?
    private var number: Int
    public var numberString: String {
        get {
            return String(describing: number)
        }
    }
    public var appName: String
    public var description: String?
    
    //
    // MARK: - Init
    //
    
    public init(background: UIImage?, number: Int, description: String? = nil) {
        self.backgroundImage = background
        self.number = number
        self.appName = "app.name".localized()
        self.description = description?.uppercased()
    }
}
