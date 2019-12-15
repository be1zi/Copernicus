//
//  ConfigurationManager.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 14/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import Foundation

struct ConfigurationManager {
    
    //
    // MARK: - Singleton
    //
    
    static let sharedInstance = ConfigurationManager()
    
    //
    // MARK: - Init
    //
    
    private init() {
        
    }
    
    //
    // MARK: - Getters
    //
    
    public var serverAddress: String? {
        return getProperty("serverAddress")
    }
    
    public var serverKey: String? {
        return getProperty("serverKey")
    }
    
    //
    // MARK: - Helpers
    //
    
    private func loadConfiguration() -> [String: Any]? {
        
        let fileURL = Bundle.main.url(forResource: "config", withExtension: "plist")
        
        guard let url = fileURL else {
            Logger.logError(description: "Configuration file not found!")
            return nil
        }
        
        let fileData: Data
        let dict: [String: Any]?
        
        do {
            fileData = try Data.init(contentsOf: url)
        } catch {
            Logger.logError(error: error)
            return nil
        }
        
        do {
            dict = try PropertyListSerialization.propertyList(from: fileData, format: nil) as? [String: Any]
        } catch {
            Logger.logError(error: error)
            return nil
        }
        
        return dict
    }
    
    private func getProperty(_ name: String) -> String? {
                
        guard let properties = loadConfiguration() else {
            Logger.logError(description: "Cant load properties from configuration file.")
            return nil
        }
        
        guard let resultList = properties["API"] as? [String: Any], let result = resultList[name] as? String else {
            Logger.logError(description: "Cant find property with name: \(name)")
            return nil
        }
        
        return result
    }
}
