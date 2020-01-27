//
//  SatelliteLocalRepository.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 01/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RealmSwift
import RxSwift
import RxRealm
import Moya

public struct SatelliteLocalRepository {
    
    //
    // MARK: - Singleton
    //
    
    public static let sharedInstance = SatelliteLocalRepository()
    
    //
    // MARK: - Get data
    //
    
    public func allSatellitesObservable() -> Observable<[SatelliteModel]> {
        let realm = try! Realm()
        //let predicate = NSPredicate(format: "properties.name IN {'Landsat-8', 'Sentinel-2A', 'Sentinel-2B'}")
        
        let satellites = realm.objects(SatelliteModel.self)
            //.filter(predicate)
            .sorted(byKeyPath: "properties.name", ascending: true)
        
        return Observable.array(from: satellites)
    }
    
    //
    // MARK: - Save data
    //
    
    public func saveSatellites(jsonResponse: Response) {
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
}
