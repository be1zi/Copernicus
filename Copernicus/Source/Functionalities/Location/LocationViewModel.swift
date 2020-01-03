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
    public var subtitle: String?
    public var info: String?
    
    public var country: String?
    public var city: String?
    public var street: String?
    public var houseNumber: String?
    public var zipCode: String?
    
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
        self.subtitle = "location.subtitle".localized()
        self.info = "location.info".localized()
        
        self.country = "location.textfield.country.placeholder".localized()
        self.city = "location.textfield.city.placeholder".localized()
        self.street = "location.textfield.street.placeholder".localized()
        self.houseNumber = "location.textfield.houseNumber.placeholder".localized()
        self.zipCode = "location.textfield.zipCode.placeholder".localized()
        
        self.skipButtonTitle = "button.skip.title".localized().uppercased()
        self.saveButtonTitle = "button.save.title".localized().uppercased()
    }
}
