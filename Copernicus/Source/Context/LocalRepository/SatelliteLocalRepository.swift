//
//  SatelliteLocalRepository.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 01/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RealmSwift
import RxSwift
import RxRealm

public struct SatelliteLocalRepository {
    
    //
    // MARK: - Singleton
    //
    
    public static let sharedInstance = SatelliteLocalRepository()
    
    //
    // MARK: - Methods
    //
    
    public func allSatellitesObservable() -> Observable<[SatelliteModel]> {
        let realm = try! Realm()
        let satellites = realm.objects(SatelliteModel.self)
        
        return Observable.array(from: satellites)
    }
}
