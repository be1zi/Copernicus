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
        self.frequency = OverpassListHeaderViewModel.calculateFrequency(frequency)
        self.frequencyName = "overpass.list.header.frequency".localized()
    }
    
    private static func calculateFrequency(_ frequency: Int) -> String {
        var value: String = ""
        
        value += "\(frequency / 86400) \("overpass.list.header.frequency.days".localized()), "
        value += "\((frequency % 86400) / 3600) \("overpass.list.header.frequency.hours".localized()), "
        value += "\((frequency % 3600) / 60) \("overpass.list.header.frequency.minutes".localized()), "
        value += "\((frequency % 3600) % 60) \("overpass.list.header.frequency.seconds".localized()) "
        
        return value + "(\(String(describing: frequency)) \("overpass.list.header.frequency.seconds".localized()))"
    }
}
