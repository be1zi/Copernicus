//
//  OverpassListFutureViewModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 06/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

public struct OverpassListFutureViewModel {
    
    //
    // MARK: - Properties
    //
    
    public var name: String?
    public var overpassName: String?
    public var inSeparator: String?
    public var time: String?
    public var imagining: String?
    public var imaginingValue: String?
    
    public init(_ model: SingleOverpassModel) {
        self.setStaticData()
        self.setDynamicData(model)
    }
    
    private mutating func setStaticData() {
        self.overpassName = "overpass.list.cell.overpass".localized()
        self.inSeparator = "overpass.list.cell.in".localized()
        self.imagining = "overpass.list.cell.imagining".localized()
    }
    
    private mutating func setDynamicData(_ model: SingleOverpassModel) {
        self.name = model.satellite
        self.time = "22 hours"

        if model.acquisition == true {
            self.imaginingValue = "boolean.true.description".localized()
        } else {
            self.imaginingValue = "boolean.false.description".localized()
        }
    }
}
