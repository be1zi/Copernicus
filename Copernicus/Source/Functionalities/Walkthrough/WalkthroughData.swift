//
//  WalkthroughData.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 19/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import UIKit

public struct WalkthroughData {

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
    
    //
    // MARK: - Init
    //
    
    public init(background: UIImage?, number: Int) {
        self.backgroundImage = background
        self.number = number
    }
}
