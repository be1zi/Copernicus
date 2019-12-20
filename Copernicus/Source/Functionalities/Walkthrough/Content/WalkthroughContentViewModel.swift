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
    
    public let backgroundImage: UIImage?
    private let number: Int
    public var numberString: String {
        get {
            return String(describing: number)
        }
    }
    public let appName: String
    public let description: String?
    public let loopTitle: String
    public let loopImageEnabled: UIImage?
    public let loopImageDisabled: UIImage?
    
    //
    // MARK: - Init
    //
    
    public init(background: UIImage?, number: Int, description: String? = nil) {
        self.backgroundImage = background
        self.number = number
        self.description = description?.uppercased()

        self.appName = "app.name".localized()
        self.loopTitle = "button.loop.description".localized()
        self.loopImageEnabled = UIImage(named: "walkthroughLoopEnabled")
        self.loopImageDisabled = UIImage(named: "walkthroughLoopDisabled")
    }
}
