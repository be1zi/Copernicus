//
//  Realm.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 31/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import Realm
import RealmSwift
import Moya

public extension Realm {
    
    static func saveSatellites(jsonResponse: Response) {
        guard let data = try? JSONSerialization.jsonObject(with: jsonResponse.data, options: []) as? [String: Any] else {
            return
        }

        guard var contentData = data["features"] as? [[String: Any]] else {
            return
        }
  
        for (index, value) in contentData.enumerated() {
            var satellite = value
            
            if var geometry = satellite["geometry"] as? [String: Any] {
                geometry["id"] = satellite["id"] ?? 0
                satellite["geometry"] = geometry
            }
            
            if var properties = satellite["properties"] as? [String: Any] {
                properties["id"] = satellite["id"]
                
                if var sensors = properties["sensors"] as? [[String: Any]] {
                    
                    for (sensorIndex, sensorValue) in sensors.enumerated() {
                        var sensor = sensorValue
                        
                        sensor["id"] = "\(satellite["id"] ?? "0")\(sensor["type"] ?? "")"
                        sensors[sensorIndex] = sensor
                    }
                    
                    properties["sensors"] = sensors
                }
                
                satellite["properties"] = properties
            }
            
            contentData[index] = satellite
        }
        
        guard let unwrappedData = try? JSONSerialization.data(withJSONObject: contentData, options: []) else {
            return
        }
        
        guard let satellites = try? JSONDecoder().decode([SatelliteModel].self, from: unwrappedData) else {
            return
        }
        
        do {
            let realm = try Realm()
            Logger.logInfo(info: realm.configuration.fileURL?.absoluteString ?? "")
            
            let existedSatellites = realm.objects(SatelliteModel.self)
            
            let newKeys = satellites.compactMap { $0.id }
            
            let toUpdate = existedSatellites.filter { newKeys.contains($0.id) }
            
            let toUpdateKeys = toUpdate.compactMap { $0.id }
            
            let toAdd = satellites.filter { !toUpdateKeys.contains($0.id) }
            let toDelete = existedSatellites.filter { !toUpdateKeys.contains($0.id) }

            for object in satellites {
                if let satellite = existedSatellites.first(where: { $0.id == object.id }) {
                    
                    try realm.write {
                        if let oldGeometry = satellite.geometry, let newGeometry = object.geometry {
                            realm.delete([oldGeometry], cascading: true)
                            let newGeometry = realm.create(SingleGeometryModel.self, value: newGeometry, update: .error)
                            satellite.geometry = newGeometry
                        }
                    }
                }
            }
            
            try realm.write {
                realm.add(toAdd)
                realm.delete(toDelete, cascading: true)
            }
        } catch {
            Logger.logError(error: error)
        }
    }
    
    static func saveTrajectory(jsonResponse: Response) {
        
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

//
// MARK: - Cascading delete
//

private extension Realm {
    func delete<S: Sequence>(_ objects: S, cascading: Bool) where S.Iterator.Element: Object {
        for obj in objects {
            delete(obj, cascading: cascading)
        }
    }

    func delete<Entity: Object>(_ entity: Entity, cascading: Bool) {
        if cascading {
            cascadeDelete(entity)
        } else {
            delete(entity)
        }
    }
}

private extension Realm {
    private func cascadeDelete(_ entity: RLMObjectBase) {
        guard let entity = entity as? Object else { return }
        var toBeDeleted = Set<RLMObjectBase>()
        toBeDeleted.insert(entity)
        while !toBeDeleted.isEmpty {
            guard let element = toBeDeleted.removeFirst() as? Object,
                !element.isInvalidated else { continue }
            resolve(element: element, toBeDeleted: &toBeDeleted)
        }
    }

    private func resolve(element: Object, toBeDeleted: inout Set<RLMObjectBase>) {
        element.objectSchema.properties.forEach {
            guard let value = element.value(forKey: $0.name) else { return }
            if let entity = value as? RLMObjectBase {
                toBeDeleted.insert(entity)
            } else if let list = value as? RealmSwift.ListBase {
                for index in 0 ..< list._rlmArray.count {
                  if let realmObject = list._rlmArray.object(at: index) as? RLMObjectBase {
                    toBeDeleted.insert(realmObject)
                  }
                }
            }
        }
        delete(element)
    }
}
