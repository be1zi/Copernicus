//
//  CloudyTableViewFooterViewModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 15/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

public struct CloudyTableViewFooterViewModel {
    
    //
    // MARK: - Properties
    //
    
    public var cloudy: String?
    
    //
    // MARK: - Init
    //
    
    public init(cloudy: Double) {
        self.cloudy = "\("cloudy.header.average".localized()): \(String(describing: cloudy))%"
    }
}
