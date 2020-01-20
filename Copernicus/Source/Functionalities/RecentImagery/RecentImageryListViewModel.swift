//
//  RecentImageryListViewModel.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 20/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RxSwift

public class RecentImageryListViewModel {
    
    //
    // MARK: - Properties
    //
    
    public let cellIdentifier = String(describing: RecentImageryTableViewCell.self)
    
    private let disposeBag = DisposeBag()
    
    public var imageryData = [ImageryResultModel]()
    public var shouldReload = ReplaySubject<Void>.create(bufferSize: 1)
    public var rowNumber: Int {
        get {
            return imageryData.count
        }
    }
    
    //
    // MARK: - Init
    //
    
    public init() {
        getLocation()
    }
    
    //
    // MARK: - Data
    //
    
    private func getLocation() {
        LocationRepository.sharedInstance.getLocationObservable().subscribe(onNext: { [unowned self] locations in
            guard let location = locations.first else { return }
            self.getImagery(location: location)
        }).disposed(by: disposeBag)
    }
    
    private func getImagery(location: LocationModel) {
        let cloudyData = CloudyData(latitude: location.latitide, longitude: location.longitude)
        
        ImageryRepository.sharedInstance.getImageryObservable(cloudyData).subscribe(onNext: { [unowned self] imageryArray in
            self.prepareData(imagery: imageryArray)
        }).disposed(by: disposeBag)
    }
    
    private func prepareData(imagery: [ImageryResultModel]) {

        var date = Date()
        date = date.addingTimeInterval(-14*24*60*60)
        
        imageryData = imagery.filter { $0.endPositionDate?.compare(date) == .orderedDescending}
        
        shouldReload.onNext(())
    }
}
