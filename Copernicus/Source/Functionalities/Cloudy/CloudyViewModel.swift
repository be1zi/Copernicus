//
//  CloudyViewModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 14/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RxSwift
import RxCocoa

public class CloudyViewModel {
    
    //
    // MARK: - Properties
    //
    
    public var title: String?
    public var subtitle: String?
    
    private let disposeBag = DisposeBag()
    private let location = ReplaySubject<LocationModel>.create(bufferSize: 1)
    private let imagery = BehaviorRelay<[ImageryResultModel]>(value: [])
    
    public var shouldReload = ReplaySubject<Void>.create(bufferSize: 1)
    public var imageryCount: Int {
        get {
            return imagery.value.count
        }
    }
    public var seasons: [String] = ["Wiosna", "Lato", "Jesień", "Zima"]
    public var seasonsCount: Int {
        get {
            return seasons.count
        }
    }
    
    public let headerIdentifier = String(describing: CloudyTableViewHeader.self)
    public let footerIdentifier = String(describing: CloudyTableViewFooter.self)
    
    //
    // MARK: - Init
    //
    
    init() {
        setStaticData()
        getCurrentLocation()
        getImageryData()
    }
    
    private func setStaticData() {
        self.title = "cloudy.header.title".localized()
        self.subtitle = "cloudy.header.subtitle".localized()
    }
    
    private func getCurrentLocation() {
        
        LocationRepository.sharedInstance.getLocationObservable().subscribe(onNext: { [unowned self] locations in
            guard let loc = locations.last else { return }
            self.location.onNext(loc)
        }).disposed(by: disposeBag)
    }
    
    private func getImageryData() {
        
        location.subscribe(onNext: { [unowned self] location in
            if location.exist() == false { return }
            let cloudyData = CloudyData(latitude: location.latitide, longitude: location.longitude)
            
            ImageryRepository.sharedInstance.getImageryObservable(cloudyData).subscribe(onNext: { [unowned self] imageryArray in
                self.imagery.accept(imageryArray)
                self.shouldReload.onNext(())
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
}
