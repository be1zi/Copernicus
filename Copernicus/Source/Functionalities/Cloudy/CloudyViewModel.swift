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
    
    public var shouldReload = ReplaySubject<Void>.create(bufferSize: 1)
    
    public var seasons = [String]()
    public var seasonsCount: Int {
        get {
            return seasons.count
        }
    }
    
    public var cloudyData = [[ImageryResultModel]]()
    
    public let headerIdentifier = String(describing: CloudyTableViewHeader.self)
    public let footerIdentifier = String(describing: CloudyTableViewFooter.self)
    public let cellIdentifier = String(describing: CloudyTableViewCell.self)
    
    //
    // MARK: - Init
    //
    
    init() {
        setStaticData()
        getCurrentLocation()
        getImageryData()
    }
    
    //
    // MARK: - Prepare data
    //
    
    private func setStaticData() {
        self.title = "cloudy.header.title".localized()
        self.subtitle = "cloudy.header.subtitle".localized()
        self.seasons = ["seasons.spring".localized(),
                        "seasons.summer".localized(),
                        "seasons.autumn".localized(),
                        "seasons.Winter".localized()]
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
                self.prepareData(imageryArray)
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
    
    private func prepareData(_ data: [ImageryResultModel]) {
        var localData = data
        
        cloudyData.removeAll()
        cloudyData.append( data.filter { Seasons.isInSeason(season: .spring, date: $0.endPositionDate) } )
        cloudyData.append( data.filter { Seasons.isInSeason(season: .summer, date: $0.endPositionDate) } )
        cloudyData.append( data.filter { Seasons.isInSeason(season: .autumn, date: $0.endPositionDate) } )
        
        cloudyData.forEach { element in
            localData = localData.filter { !element.contains($0) }
        }
        
        cloudyData.append(localData)
        
        shouldReload.onNext(())
    }
    
    //
    // MARK: - Get data
    //
    
    public func numberOfRowsInSection(_ section: Int) -> Int {
        return section <= cloudyData.count ? cloudyData[section].count : 0
    }
    
    public func dataForCell(atIndexPath indexPath: IndexPath) -> ImageryResultModel {
        return cloudyData[indexPath.section][indexPath.row]
    }
    
    public func titleForSection(_ section: Int) -> String {
        return section <= seasons.count ? seasons[section] : ""
    }
    
    public func averageCloudyForSection(_ section: Int) -> Double {
        
        if section > cloudyData.count {
            return 0.0
        }
        let average = cloudyData[section].map { $0.cloudCoverPercentage }.reduce(0.0, +) / Double(cloudyData[section].count)
        
        return (average * 100).rounded() / 100
    }
}
