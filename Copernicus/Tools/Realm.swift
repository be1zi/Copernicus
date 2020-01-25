//
//  Realm.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 31/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import Realm
import RealmSwift

public extension Realm {
    
    //
    // MARK: - Cascading delete
    //
    
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
    
    func entitiesToClear(without: [Object.Type]) -> [Object.Type] {
        var mainEntityList = [LocationModel.self,
                              SatelliteModel.self,
                              TrajectoryModel.self,
                              OverpassModel.self,
                              ImageryResultModel.self,
                              SynchroInfo.self]
        
        mainEntityList = mainEntityList.filter { element in
            !without.contains(where: { element == $0 })
        }
        
        return mainEntityList
    }
    
    func allEntities() -> [Object.Type] {
        return entitiesToClear(without: [])
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
