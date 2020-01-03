//
//  LocationLocalRepository.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 03/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RealmSwift

public struct LocationLocalRepository {
    
    //
    // MARK: - Singleton
    //
    
    public static let sharedInstance = LocationLocalRepository()
    
    //
    // MARK: - Methods
    //
    
    public func saveLocation(_ data: LocationData) {
        
        let realm = try! Realm()
        let object = LocationModel(data)
        
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            Logger.logError(error: error)
        }
    }
}
