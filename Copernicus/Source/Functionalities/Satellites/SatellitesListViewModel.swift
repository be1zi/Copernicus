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
    public var satellitesCount: Int {
        get {
            return satellites.value.count
        }
    }
    public let cellName = String(describing: SatellitesListCell.self)
    
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
                self.satellites.accept(satellites)
        }).disposed(by: disposeBag)
    }
}
