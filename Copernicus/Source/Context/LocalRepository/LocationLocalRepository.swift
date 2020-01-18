//
//  LocationLocalRepository.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 03/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RealmSwift
import RxSwift

public struct LocationLocalRepository {
    
    //
    // MARK: - Singleton
    //
    
    public static let sharedInstance = LocationLocalRepository()
    private let disposeBag = DisposeBag()
    
    //
    // MARK: - Methods
    //
    
    public func saveLocation(_ data: LocationData) -> Single<Void> {
        
        let realm = try! Realm()
        let object = LocationModel(data)

        return Single.create { single in

            if data.useMyLocation == true, let _ = data.latitude, let _ = data.longitude {
                do {
                    try realm.write {
                        var entityToClear = [Object.Type]()
                        if data.type == .Default {
                            realm.delete(realm.objects(LocationModel.self), cascading: true)
                            entityToClear = realm.entitiesToClear(without: [LocationModel.self])
                        } else {
                            let objects = realm.objects(LocationModel.self).filter(NSPredicate(format: "id = %@", argumentArray: [object.id]))
                            realm.delete(objects, cascading: true)
                            entityToClear = [OverpassModel.self]
                        }
                        
                        entityToClear.forEach { entity in
                            realm.delete(realm.objects(entity), cascading: true)
                        }
                        
                        realm.add(object)
                    }
                    
                    single(.success(()))
                } catch {
                    Logger.logError(error: error)
                    single(.error(error))
                }
            } else {
                object.createCoordinates().subscribe(onSuccess: { _ in
                    do {
                        try realm.write {
                            var entitiesToClear = [Object.Type]()
                            if data.type == .Default {
                                realm.delete(realm.objects(LocationModel.self), cascading: true)
                                entitiesToClear = realm.entitiesToClear(without: [LocationModel.self])
                            } else {
                                let objects = realm.objects(LocationModel.self).filter(NSPredicate(format: "id = %@", argumentArray: [object.id]))
                                realm.delete(objects, cascading: true)
                                entitiesToClear = [OverpassModel.self]
                            }
                            
                            entitiesToClear.forEach { entity in
                                realm.delete(realm.objects(entity), cascading: true)
                            }
                            
                            realm.add(object)
                        }
                        
                        single(.success(()))
                    } catch {
                        Logger.logError(error: error)
                        single(.error(error))
                    }
                }) { error in
                    single(.error(error))
                }.disposed(by: LocationLocalRepository.sharedInstance.disposeBag)
            }
            return Disposables.create()
        }
    }
    
    public func getLocationObservable() -> Observable<[LocationModel]> {
        let realm = try! Realm()
        
        let location = realm.objects(LocationModel.self)
        
        return Observable.array(from: location)
    }
}
