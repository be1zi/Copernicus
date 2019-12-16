//
//  String.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 16/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import Foundation

extension String {
    
    func localized() -> String {
        
        let currentLanguage = LanguageManager.sharedInstance.currentLanguage
        
        guard let path: String = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") else {
            return self
        }
        
        guard let bundle: Bundle = Bundle.init(path: path) else {
            return self
        }
        
        return bundle.localizedString(forKey: self, value: nil, table: nil)
    }
}
