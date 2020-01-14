//
//  HomeViewModel.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 17/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import UIKit

struct HomeViewModel {
    
    //
    // MARK: - Properties
    //
    
    public var cellViewModels: [HomeCellViewModel]!
    public var cellsNumber: Int = 0
    public let appName: String
    public let headerBackground: UIImage?
    public let ovalImage: UIImage?
    
    //
    // MARK: - Init
    //
    
    init() {
        self.appName = "app.name.short".localized()
        self.headerBackground = UIImage(named: "homeHeaderBackground")
        self.ovalImage = UIImage(named: "homeOvalImage")
        
        self.setupCellViewModels()        
    }
    
    //
    // MARK: - Methods
    //
    
    private mutating func setupCellViewModels() {
        
        cellViewModels = [HomeCellViewModel(title: "home.menu.item1".localized(), imageName: "menuSatellite", storyboardName: "Satellites"),
                          HomeCellViewModel(title: "home.menu.item1".localized(), storyboardName: "Overpass"),
                          HomeCellViewModel(title: "home.menu.item2".localized()),
                          HomeCellViewModel(title: "home.menu.item3".localized(), imageName: "menuClouds", storyboardName: "Cloudy"),
                          HomeCellViewModel(title: "home.menu.item4".localized()),
                          HomeCellViewModel(title: "home.menu.item5".localized()),
                          HomeCellViewModel(title: "home.menu.item6".localized()),
                          HomeCellViewModel(title: "home.menu.item7".localized(), imageName: "menuSettings", storyboardName: "Settings")]
        
        cellsNumber = cellViewModels.count
    }
}
