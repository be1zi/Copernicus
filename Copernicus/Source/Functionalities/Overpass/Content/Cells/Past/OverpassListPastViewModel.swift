//
//  OverpassListPastViewModel.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 08/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import Foundation

public struct OverpassListPastViewModel {
    
    //
    // MARK: - Properties
    //
    
    public var satellite: String?
    public var imageName: String?
    public var agoSeparator: String?
    public var time: String?
    public var clouds: String?
    public var cloudsValue: String?
    
    //
    // MARK: - Init
    //
       
    public init(_ model: SingleOverpassModel) {
        self.setStaticData()
        self.setDynamicData(model)
    }
       
    //
    // MARK: - Data
    //
       
    private mutating func setStaticData() {
        self.imageName = "overpass.list.cell.image".localized()
        self.agoSeparator = "overpass.list.cell.ago".localized()
        self.clouds = "overpass.list.cell.clouds".localized()
    }
       
    private mutating func setDynamicData(_ model: SingleOverpassModel) {
        self.satellite = model.satellite
        self.time = DateFormatter.dateToString(date: model.date)
        
//
//        if model.acquisition == true {
//            self.imaginingValue = "boolean.true.description".localized()
//        } else {
//            self.imaginingValue = "boolean.false.description".localized()
//        }
    }
}
