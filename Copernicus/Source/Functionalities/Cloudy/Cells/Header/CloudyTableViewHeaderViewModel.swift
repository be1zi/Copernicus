//
//  CloudyTableViewHeaderViewModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 15/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

public struct CloudyTableViewHeaderViewModel {
    
    //
    // MARK: - Properties
    //
    
    public var title: String?
    public var date: String?
    public var satellite: String?
    public var cloudy: String?
    
    //
    // MARK: - Init
    //
    
    public init(title: String) {
        self.title = title
        self.setStaticData()
    }
    
    //
    // MARK: - Data
    //
    
    private mutating func setStaticData() {
        self.date = "cloudy.header.date".localized()
        self.satellite = "cloudy.header.satellite".localized()
        self.cloudy = "cloudy.header.cloudy".localized()
    }
}
