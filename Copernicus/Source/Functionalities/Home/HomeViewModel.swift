//
//  HomeViewModel.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 17/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

struct HomeViewModel {
    
    //
    // MARK: - Properties
    //
    
    public var cellViewModels: [HomeCellViewModel]!
    public var cellsNumber: Int = 0
    
    //
    // MARK: - Init
    //
    
    init() {
        self.setupCellViewModels()
    }
    
    //
    // MARK: - Methods
    //
    
    private mutating func setupCellViewModels() {
        
        cellViewModels = [HomeCellViewModel(title: "home.menu.item1".localized(), imageName: "menuSatellite"),
                          HomeCellViewModel(title: "home.menu.item2".localized()),
                          HomeCellViewModel(title: "home.menu.item3".localized()),
                          HomeCellViewModel(title: "home.menu.item4".localized()),
                          HomeCellViewModel(title: "home.menu.item5".localized()),
                          HomeCellViewModel(title: "home.menu.item6".localized()),
                          HomeCellViewModel(title: "home.menu.item7".localized())]
        
        cellsNumber = cellViewModels.count
    }
}
