//
//  SatellitesListViewModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 30/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import RxSwift

public class SatellitesListViewModel {
    
    //
    // MARK: - Properties
    //
    private let disposeBag = DisposeBag()
    
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
        
        SatelliteRepository.sharedInstance.getSatellitesObservable().subscribe(onSuccess: { [weak self] response in
            print(response)
        }) { [weak self] error in
            print(error.localizedDescription)
        }.disposed(by: disposeBag)
    }
}
