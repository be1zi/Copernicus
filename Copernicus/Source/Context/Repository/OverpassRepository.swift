//
//  OverpassRepository.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 04/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import Moya
import RxSwift

public struct OverpassRepository {
    
    //
    // MARK: - Properties
    //
    
    public static let sharedInstance = OverpassRepository()
    private let provider = MoyaProvider<OverpassRemoteRepository>()
    private let disposeBag = DisposeBag()
    
    //
    // MARK: - Methods
    //
    
    public func getOverpassObservable(data: OverpassData) -> Observable<[OverpassModel]> {
        
        if SynchroManager.sharedInstance.shouldSynchronize(type: OverpassModel.self) {
        
            provider.rx.request(.overpass(data)).map { response in
                OverpassLocalRepository.sharedInstance.saveOverpass(response)
                SynchroManager.sharedInstance.synchronized(type: OverpassModel.self)
            }
            .subscribe()
            .disposed(by: disposeBag)
        }
            
        return OverpassLocalRepository.sharedInstance.getOverpassObservable()
    }
}
