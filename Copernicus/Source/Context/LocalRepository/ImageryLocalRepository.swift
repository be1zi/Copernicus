//
//  ImageryLocalRepository.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 15/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RxSwift
import RealmSwift

public struct ImageryLocalRepository {
    
    //
    // MARK: - Singleton
    //
    
    public static let sharedInstance = ImageryLocalRepository()
    
    //
    // MARK: - Get data
    //
    
    public func imageryObservable() -> Observable<[ImageryModel]> {
        let realm = try! Realm()
        
        let imagery = realm.objects(ImageryModel.self)
        
        return Observable.array(from: imagery)
    }
}
