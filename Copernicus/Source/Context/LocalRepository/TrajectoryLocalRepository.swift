//
//  TrajectoryLocalRepository.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 02/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RealmSwift
import RxSwift
import RxRealm

public struct TrajectoryLocalRepository {
    
    //
    // MARK: - Singleton
    //
    
    public static let sharedInstance = TrajectoryLocalRepository()
    
    //
    // MARK: - Methods
    //
    
    public func trajectoryObservable(satelliteId: Int) -> Observable<TrajectoryModel> {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "id == \(satelliteId)")
    
        let trajectory = realm.objects(TrajectoryModel.self).filter(predicate).first
        
        return Observable.from(optional: trajectory)
    }
}
