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
    
    public func getOverpassObservable(data: OverpassData, type: OverpassCellType) -> Observable<[OverpassModel]> {
        
        provider.rx.request(.overpass(data)).map { response in
            OverpassLocalRepository.sharedInstance.saveOverpass(response)
        }
        .subscribe()
        .disposed(by: disposeBag)
        
        return OverpassLocalRepository.sharedInstance.getOverpassObservable()
    }
}
