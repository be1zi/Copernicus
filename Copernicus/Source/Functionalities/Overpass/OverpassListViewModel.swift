//
//  OverpassListViewModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 04/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//
import RxSwift

public class OverpassListViewModel {
    
    //
    // MARK: - Properties
    //
    
    public var title: String?
    public var subtitle: String?
    public var changeButton: String = ""
    
    private let disposeBag = DisposeBag()
    public let location = ReplaySubject<LocationModel>.create(bufferSize: 1)
    public var locationSelected: Bool = false
//    public var satellitesCount: Int {
//        get {
//            return satellites.value.count
//        }
//    }
//    public let cellName = String(describing: SatellitesListCell.self)
    
    //
    // MARK: - Init
    //
    
    public init() {
        setStaticProperties()
        
        getCurrentLocation()
    }
    
    //
    // MARK: - Data
    //
    
    private func setStaticProperties() {
        self.title = "overpass.list.title".localized()
        self.subtitle = "overpass.list.selectedLocation.title".localized()
        self.changeButton = "button.change.title".localized()
    }
    
    private func getCurrentLocation() {
        
        LocationRepository.sharedInstance.getLocationObservable().subscribe(onNext: { [unowned self] location in
            self.location.onNext(location)
            self.locationSelected = location.exist()
        }).disposed(by: disposeBag)
    }
}
