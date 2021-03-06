//
//  OverpassLocalRepository.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 04/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import Moya
import RealmSwift
import RxSwift

public struct OverpassLocalRepository {
    
    //
    // MARK: - Singleton
    //
    
    public static let sharedInstance = OverpassLocalRepository()
    
    //
    // MARK: - Get
    //
    
    public func getOverpassObservable() -> Observable<[OverpassModel]> {
        let realm = try! Realm()
        
        let overpasses = realm.objects(OverpassModel.self)
        
        return Observable.array(from: overpasses)
    }
    
    //
    // MARK: - Save
    //
    
    public func saveOverpass(_ jsonResponse: Response) {

        guard var data = try? JSONSerialization.jsonObject(with: jsonResponse.data, options: []) as? [String: Any] else {
            return
        }
        
        if var overpasses = data["overpasses"] as? [[String: Any]] {
            for (index, value) in overpasses.enumerated() {
                var overpass = value
                overpass["id"] = index
                
                if var geometry = overpass["geometry"] as? [String: Any] {
                    geometry["id"] = overpass["id"]
                    overpass["geometry"] = geometry
                }
                
                if var footprint = overpass["footprint"] as? [String: Any] {
                    footprint["id"] = overpass["id"]
                    overpass["footprint"] = footprint
                }
                
                overpasses[index] = overpass
            }
            
            data["overpasses"] = overpasses
        }
        
        guard let unwrappedData = try? JSONSerialization.data(withJSONObject: data, options: []) else {
            return
        }
        
        guard let overpass = try? JSONDecoder().decode(OverpassModel.self, from: unwrappedData) else {
            return
        }
        
        do {
            let realm = try Realm()
            Logger.logInfo(info: realm.configuration.fileURL?.absoluteString ?? "")
            
            try realm.write {
                realm.add(overpass, update: .modified)
            }
        } catch {
            Logger.logError(error: error)
        }
    }
}
