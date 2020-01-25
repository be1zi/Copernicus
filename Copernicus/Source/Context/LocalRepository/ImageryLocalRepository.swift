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
        
        let imagery = realm.objects(ImageryResultModel.self).sorted(byKeyPath: "endPositionDate", ascending: true)
        
        return Observable.array(from: imagery)
    }
    
    public func imagesObservable(withId id: Int) -> Observable<[ImageModel]> {
        
        let predicate = NSPredicate(format: "id contains %@", argumentArray: ["\(id)_"])
        
        let realm = try! Realm()
        
        let images = realm.objects(ImageModel.self).filter(predicate)
        
        return Observable.array(from: images)
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
    
    public func saveImageryArray(_ jsonResponse: [Response]) {
        
        let result = jsonResponse.compactMap { try? JSONSerialization.jsonObject(with: $0.data, options: []) as? [String: Any] }
            .compactMap { $0["results"] as? [[String: Any]] }
            .compactMap { try? JSONSerialization.data(withJSONObject: $0, options: []) }
            .compactMap { try? JSONDecoder().decode([ImageryResultModel].self, from: $0) }
            .flatMap { $0 }
        
        do {
            let realm = try Realm()
            
            try realm.write {
                realm.add(result, update: .modified)
            }
        } catch {
            Logger.logError(error: error)
        }
    }
    
    public func saveImageArray(forImageId id: Int, jsonResponse: Response) {
        
        guard let data = try? JSONSerialization.jsonObject(with: jsonResponse.data, options: []) as? [[String: Any]] else {
            return
        }
        
        let previews = data.filter {
            guard let path = $0["path"] as? String else { return false }
            if path.contains("preview/") { return true }
            
            return false
        }
        
        var results = [[String: Any]]()
        
        for (index, element) in previews.enumerated() {
            var el = element
            
            if let name = el["name"] as? String {
                el["id"] = "\(id)_\(name)"
            } else {
                el["id"] = "\(id)_\(index)"
            }
            
            results.append(el)
        }
        
        guard let unwrappedData = try? JSONSerialization.data(withJSONObject: results, options: []) else {
            return
        }
        
        guard let images = try? JSONDecoder().decode([ImageModel].self, from: unwrappedData) else {
            return
        }
        
        do {
            let realm = try Realm()
            
            try realm.write {
                realm.add(images, update: .modified)
            }
        } catch {
            Logger.logError(error: error)
        }
    }
}
