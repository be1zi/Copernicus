//
//  LocalRepository.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 19/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RealmSwift

public struct LocalRepository {
    
    //
    // MARK: - Properties
    //
    
    static let sharedInstance = LocalRepository()
    
    //
    // MARK: - Methods
    //
    
    public func clearDatabase() {
        let realm = try! Realm()
        let entitiesToDelete = realm.allEntities()
        
        do {
            try realm.write {
                entitiesToDelete.forEach { entity in
                    realm.delete(realm.objects(entity), cascading: true)
                }
            }
        } catch {
            Logger.logError(error: error)
        }
    }
}
