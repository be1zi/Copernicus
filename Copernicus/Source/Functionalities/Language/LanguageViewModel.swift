//
//  LanguageViewModel.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 16/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

struct LanguageViewModel {

    //
    // MARK: - Properties
    //
    
    var polishButtonTitle: String!
    var englishButtonTitle: String!
    
    //
    // MARK: - Init
    //
    
    init() {
        self.loadTranslations()
    }
    
    //
    // MARK: - Methods
    //
    
    private mutating func loadTranslations() {
        polishButtonTitle = ""
        englishButtonTitle = ""
    }
}
