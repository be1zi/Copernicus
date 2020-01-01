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
    
    public func getSatellitesObservable() -> Observable<[SatelliteModel]> {
        
//        SatelliteLocalRepository.sharedInstance.allSatellitesObservable().subscribe(onNext: { [weak self] objects in
//            print("From database:", objects.count)
//            }).disposed(by: disposeBag)
//
//        SatelliteRepository.sharedInstance.getSatellitesObservable().subscribe(onSuccess: { [weak self] response in
//            print("From network:", response)
//        }) { [weak self] error in
//            print(error.localizedDescription)
//        }.disposed(by: disposeBag)
        
        
//        return provider.rx.request(.allSatellites).map { response in
//            Realm.saveSatellites(jsonResponse: response)
//        }
        
        
        // if need synchronize
        
        _ = provider.rx.request(.allSatellites).map { response in
            Realm.saveSatellites(jsonResponse: response)
        }
                
        return SatelliteLocalRepository.sharedInstance.allSatellitesObservable()
    }
}
