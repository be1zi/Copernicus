//
//  LocationViewModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 02/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

public struct LocationViewModel {
    
    //
    // MARK: - Properties
    //
    
    public var title: String?
    public var skipButtonTitle: String = ""
    public var saveButtonTitle: String = ""
    public var selectedLanguage: String {
        return LanguageManager.sharedInstance.currentLanguage.uppercased()
    }
    
    public init() {
        self.setupData()
    }
    
    //
    // MARK: - Prepare data
    //
    
    private mutating func setupData() {
        self.title = "app.name.long".localized()
        self.skipButtonTitle = "button.skip.title".localized().uppercased()
        self.saveButtonTitle = "button.save.title".localized().uppercased()
    }
}
