//
//  ImageryLocalRepository.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 15/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RxSwift
import RealmSwift
import Moya

public struct ImageryLocalRepository {
    
    //
    // MARK: - Singleton
    //
    
    public static let sharedInstance = ImageryLocalRepository()
    
    //
    // MARK: - Get data
    //
    
    public func imageryObservable() -> Observable<[ImageryResultModel]> {
        let realm = try! Realm()
        
        let imagery = realm.objects(ImageryResultModel.self)
        
        return Observable.array(from: imagery)
    }
    
    //
    // MARK: - Save data
    //
    
    public func saveImagery(jsonResponse: Response) {
        guard let data = try? JSONSerialization.jsonObject(with: jsonResponse.data, options: []) as? [String: Any] else {
            return
        }
        
        guard let results = data["results"] as? [[String: Any]] else {
            return
        }
        
        guard let unwrappedData = try? JSONSerialization.data(withJSONObject: results, options: []) else {
            return
        }
        
        guard let imagery = try? JSONDecoder().decode([ImageryResultModel].self, from: unwrappedData) else {
            return
        }
        
        do {
            let realm = try Realm()
            
            try realm.write {
                realm.add(imagery, update: .modified)
            }
        } catch {
            Logger.logError(error: error)
        }
    }
}
