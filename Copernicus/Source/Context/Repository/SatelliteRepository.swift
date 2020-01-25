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
                
        if SynchroManager.sharedInstance.shouldSynchronize(type: SatelliteModel.self) {
        
            provider.rx.request(.allSatellites).map { response in
                SatelliteLocalRepository.sharedInstance.saveSatellites(jsonResponse: response)
                SynchroManager.sharedInstance.synchronized(type: SatelliteModel.self)
            }
            .subscribe()
            .disposed(by: disposeBag)
        }
                
        return SatelliteLocalRepository.sharedInstance.allSatellitesObservable()
    }
}
