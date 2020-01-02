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
    private let disposeBag = DisposeBag()
    
    //
    // MARK: - Methods
    //
    
    public func getSatellitesObservable() -> Observable<[SatelliteModel]> {
        
        // if need synchronize
        
        provider.rx.request(.allSatellites).map { response in
            Realm.saveSatellites(jsonResponse: response)
            }
        .subscribe()
        .disposed(by: disposeBag)
                
        return SatelliteLocalRepository.sharedInstance.allSatellitesObservable()
    }
}
