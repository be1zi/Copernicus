//
//  SettingsViewModel.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 20/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

public struct SettingsViewModel {
    
    //
    // MARK: - Properties
    //
    
    public var title: String?
    public var subtitle: String?
    public var saveButton: String = ""
    
    //
    // MARK: Init
    //
    
    public init() {
        self.setStaticData()
    }
    
    //
    // MARK: - Data
    //
    
    private mutating func setStaticData() {
        self.title = "settings.title".localized()
        self.subtitle = "settings.subtitle".localized()
        self.saveButton = "button.save.title".localized()
    }
}
