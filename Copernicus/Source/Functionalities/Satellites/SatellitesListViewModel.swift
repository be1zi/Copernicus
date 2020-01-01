//
//  SatellitesListViewModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 30/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import RxSwift
import RxCocoa

public class SatellitesListViewModel {
    
    //
    // MARK: - Properties
    //
    
    private let disposeBag = DisposeBag()
    public let satellites = BehaviorRelay<[SatelliteModel]>(value: [])
    
    //
    // MARK: - Init
    //
    
    init() {
        getSatellites()
    }
    
    //
    // MARK: - Methods
    //
    
    private func getSatellites() {
        
        SatelliteRepository.sharedInstance
            .getSatellitesObservable()
            .subscribe(onNext: { [unowned self] satellites in
                print(satellites.count)
                self.satellites.accept(satellites)
        }).disposed(by: disposeBag)
    }
}
