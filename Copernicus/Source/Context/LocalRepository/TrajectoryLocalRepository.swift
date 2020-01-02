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
import Moya

public struct TrajectoryLocalRepository {
    
    //
    // MARK: - Singleton
    //
    
    public static let sharedInstance = TrajectoryLocalRepository()
    
    //
    // MARK: - Get data
    //
    
    public func trajectoryObservable(satelliteId: Int) -> Observable<TrajectoryModel> {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "id == \(satelliteId)")
    
        let trajectory = realm.objects(TrajectoryModel.self).filter(predicate).first
        
        return Observable.from(optional: trajectory)
    }
    
    //
    // MARK: - Save data
    //
    
    public func saveTrajectory(jsonResponse: Response) {
         
         guard var data = try? JSONSerialization.jsonObject(with: jsonResponse.data, options: []) as? [String: Any] else {
             return
         }
         
         if var geometry = data["geometry"] as? [String: Any] {
             geometry["id"] = data["id"]
             data["geometry"] = geometry
         }
         
         guard let unwrappedData = try? JSONSerialization.data(withJSONObject: data, options: []) else {
             return
         }
         
         guard let trajectory = try? JSONDecoder().decode(TrajectoryModel.self, from: unwrappedData) else {
             return
         }
         
         do {
             let realm = try Realm()
             Logger.logInfo(info: realm.configuration.fileURL?.absoluteString ?? "")
             
             try realm.write {
                 realm.add(trajectory, update: .modified)
             }
         } catch {
             Logger.logError(error: error)
         }
     }
}
