//
//  OverpassListHeaderViewModel.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 07/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

public struct OverpassListHeaderViewModel {
    
    //
    // MARK: - Properties
    //
    
    public let frequency: String
    public let frequencyName: String
    
    //
    // MARK: - Init
    //
    
    public init(frequency: Int) {
        self.frequency = String(describing: frequency)
        self.frequencyName = "overpass.list.header.frequency".localized()
    }
}
