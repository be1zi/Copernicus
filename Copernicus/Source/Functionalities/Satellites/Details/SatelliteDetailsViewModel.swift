//
//  SatelliteDetailsViewModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 02/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RxSwift
import RxCocoa

public class SatelliteDetailsViewModel {
    
    //
    // MARK: - Properties
    //
    
    private let satellite: SatelliteModel
    private var trajectory = ReplaySubject<TrajectoryModel>.create(bufferSize: 1)
    public var changed = ReplaySubject<Void>.create(bufferSize: 1)
    private let disposeBag = DisposeBag()
    
    public var title: String? {
        get {
            return satellite.properties?.name
        }
    }
    
    //
    // MARK: - Init
    //
    
    init(satellite: SatelliteModel) {
        self.satellite = satellite
        
        getTrajectory()
    }
    
    //
    // MARK: - Data
    //
    
    private func getTrajectory() {
        
        TrajectoryRepository.sharedInstance.getTrajectoryObservable(satelliteId: satellite.id)
            .subscribe(onNext: { [unowned self] trajectory in
                self.trajectory.onNext(trajectory)
                self.changed.onNext(())
        }).disposed(by: disposeBag)
    }
}
