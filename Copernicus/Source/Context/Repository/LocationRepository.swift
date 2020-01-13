//
//  LocationRepository.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 04/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RxSwift

public struct LocationRepository {
    
    //
    // MARK: - Properties
    //
    
    public static let sharedInstance = LocationRepository()
    
    private let disposeBag = DisposeBag()
    
    //
    // MARK: - Methods
    //
    
    public func getLocationObservable() -> Observable<[LocationModel]> {
        
        return LocationLocalRepository.sharedInstance.getLocationObservable()
    }
}
