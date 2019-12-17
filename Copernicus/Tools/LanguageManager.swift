//
//  LanguageManager.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 16/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import Foundation

private enum Language: String {
    case pl
    case en
}

public struct LanguageManager {
    
    //
    // MARK: - Singleton
    //
    
    static var sharedInstance = LanguageManager()
    
    //
    // MARK: - Properties
    //
    
    private let languageKey = "currentLanguage"
    
    public var currentLanguage: String {
        set {
            UserDefaults.standard.set(newValue, forKey: languageKey)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.object(forKey: languageKey) as? String ?? Language.pl.rawValue
        }
    }
    
    //
    // MARK: - Methods
    //
    
    public func selectedBefore() -> Bool {
        return UserDefaults.standard.object(forKey: languageKey) as? String != nil
    }
}
