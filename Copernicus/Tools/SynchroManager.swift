//
//  SynchroManager.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 25/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RealmSwift
import Realm

private enum SynchroInterval {
    case Satellite  // 60 * 60 * 24
    case Trajectory // 60 * 60 * 24
    case Overpass   // 60 * 15
    case Imagery    // 60 * 15
    
    private func value() -> Double {
        switch self {
        case .Satellite, .Trajectory:
            return 60.0 * 1
        case .Overpass, .Imagery:
            return 60.0 * 15
        }
    }
    
    static func intervalForModel(type: Object.Type) -> Double {
        if type == SatelliteModel.self {
            return SynchroInterval.Satellite.value()
        }
        
        if type == TrajectoryModel.self {
            return SynchroInterval.Trajectory.value()
        }
        
        if type == OverpassModel.self {
            return SynchroInterval.Overpass.value()
        }
        
        if type == ImageModel.self {
            return SynchroInterval.Imagery.value()
        }
        
        return 0
    }
}

public struct SynchroManager {
    
    //
    // MARK: - Singleton
    //
    
    static var sharedInstance = SynchroManager()
    
    //
    // MARK: - Methods
    //
    
    public func shouldSynchronize(type: Object.Type) -> Bool {
        
        let realm = try! Realm()
        let predicate = NSPredicate(format: "id = %@", argumentArray: [type.description()])
        
        let objects = realm.objects(SynchroInfo.self).filter(predicate)
        
        guard let obj = objects.first, let objDate = obj.date else { return true }
                
        if abs(objDate.timeIntervalSinceNow) < SynchroInterval.intervalForModel(type: type) {
            return false
        }
        
        return true
    }
    
    public func synchronized(type: Object.Type) {
        
        let realm = try! Realm()
        let predicate = NSPredicate(format: "id = %@", argumentArray: [type.description()])
        
        let objects = realm.objects(SynchroInfo.self).filter(predicate)
        
        if let obj = objects.first {
            
            do {
                try realm.write {
                    obj.date = Date()
                }
            } catch {
                Logger.logError(error: error)
            }
        } else {
            let newObj = SynchroInfo(type.description(), date: Date())
            
            do {
                try realm.write {
                    realm.add(newObj, update: .modified)
                }
            } catch {
                Logger.logError(error: error)
            }
        }
    }
}
