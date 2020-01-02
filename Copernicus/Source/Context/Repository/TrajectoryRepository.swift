//
//  TrajectoryRepository.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 02/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RxSwift
import Moya
import RealmSwift

public struct TrajectoryRepository {
    
    //
    // MARK: - Properties
    //
    
    public static let sharedInstance = TrajectoryRepository()
    private let provider = MoyaProvider<TrajectoryRemoteRepository>()
    private let disposeBag = DisposeBag()
    
    //
    // MARK: - Methods
    //
    
    public func getTrajectoryObservable(satelliteId id: Int) -> Observable<TrajectoryModel> {
        
        provider.rx.request(.trajectory(satelliteId: id)).map { response in
            Realm.saveTrajectory(jsonResponse: response)
        }
        .subscribe()
        .disposed(by: disposeBag)
        
        return TrajectoryLocalRepository.sharedInstance.trajectoryObservable(satelliteId: id)
    }
}
