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
    private var locationSelected: Bool = false
    public var locationString = ""
    
    public let overpass = ReplaySubject<OverpassModel>.create(bufferSize: 1)
    
    public var overpassData = OverpassData()
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
        getData()
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
            self.setLocationData(location)
        }).disposed(by: disposeBag)
    }
    
    private func setLocationData(_ loc: LocationModel) {
        if locationSelected {
            locationString = loc.toString()
        } else {
            locationString = "overpass.list.selectedLocation.notChoosed".localized()
        }
    }
    
    private func getData() {
        
        OverpassRepository.sharedInstance.getOverpassObservable(data: overpassData).subscribe(onNext: { [unowned self] overpass in
            self.overpass.onNext(overpass)
            print(overpass)
        }).disposed(by: disposeBag)
    }
}
