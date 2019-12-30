//
//  SatelliteRepository.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 30/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import RxSwift
import Moya
import RealmSwift

public struct SatelliteRepository {
    
    //
    // MARK: - Properties
    //
    
    public static let sharedInstance = SatelliteRepository()
    private let provider = MoyaProvider<SatelliteRemoteRepository>()
    
    //
    // MARK: - Methods
    //
    
    public func getSatellitesObservable() -> Single<Void> {
        return provider.rx.request(.allSatellites).map { response in

            guard let data = try? JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any] else {
                return
            }

            guard let contentData = data["features"] as? [[String: Any]] else {
                return
            }

            guard let unwrappedData = try? JSONSerialization.data(withJSONObject: contentData, options: []) else {
                return
            }
            
            guard let satellites = try? JSONDecoder().decode([SatelliteModel].self, from: unwrappedData) else {
                return
            }
            
            let realm = try Realm()
            print(realm.configuration.fileURL?.absoluteString ?? "")
            
            try realm.write {
                realm.add(satellites)
            }
        }
    }
}
