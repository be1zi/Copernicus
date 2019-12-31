//
//  Realm.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 31/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

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
                geometry["id"] = value["id"] ?? 0
                satellite["geometry"] = geometry
                contentData[index] = satellite
            }
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
            
            try realm.write {
                realm.add(satellites)
            }
        } catch {
            Logger.logError(error: error)
        }
    }
}
