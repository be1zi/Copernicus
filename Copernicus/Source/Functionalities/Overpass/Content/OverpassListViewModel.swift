//
//  OverpassListViewModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 04/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RxSwift

public enum OverpassCellType: String {
    case Future = "OverpassListFutureTableViewCell"
    case Past = "OverpassListPastTableViewCell"
}

public struct OverpassCellModel {
    
    public var overpass: SingleOverpassModel
    public var cloudy: ImageryResultModel?
    
    public init(overpass: SingleOverpassModel, cloudy: ImageryResultModel? = nil) {
        self.overpass = overpass
        self.cloudy = cloudy
    }
}

public class OverpassListViewModel {
    
    //
    // MARK: - Properties
    //
    
    public let cellIdentifiers = [OverpassCellType.Future.rawValue,
                                  OverpassCellType.Past.rawValue]
    public let headerIdentifier = String(describing: OverpassListHeaderTableViewCell.self)
    
    public let changed = ReplaySubject<Void>.create(bufferSize: 1)
    public var cellModels: [OverpassCellModel] = []
    public var cellNumber: Int  {
        get {
            return cellModels.count
        }
    }
    public var frequency = 0
    public let cellType: OverpassCellType
    
    private let disposeBag = DisposeBag()
    
    //
    // MARK: - Init
    //
    
    public init(type: OverpassCellType) {
        self.cellType = type
        getLocation()
    }
    
    //
    // MARK: - Data
    //

    private func getLocation() {
        
        LocationRepository.sharedInstance.getLocationObservable().subscribe(onNext: { [unowned self] locations in
            guard let loc = locations.last else { return }
            self.getData(loc)
        }).disposed(by: disposeBag)
    }
    
    private func getData(_ location: LocationModel) {
        
        let overpassData = OverpassData(latitude: location.latitide, longitude: location.longitude)
        let cloudyData = CloudyData(latitude: location.latitide, longitude: location.longitude)
        
        let overpassObservable = OverpassRepository.sharedInstance.getOverpassObservable(data: overpassData).asObservable()
        let cloudyObservable = ImageryRepository.sharedInstance.getImageryObservable(cloudyData)
        
        Observable.zip(overpassObservable, cloudyObservable).subscribe(onNext: { [unowned self] overpasses, cloudy in
            self.setData(overpasses, cloudy: cloudy)
        }).disposed(by: disposeBag)
    }
    
    private func setData(_ overpasses: [OverpassModel], cloudy: [ImageryResultModel]) {
        guard let overpass = overpasses.first else { return }
        let currentDate = Date()
        var overpassArray = [SingleOverpassModel]()
        
        switch cellType {
            case .Future:
                overpassArray = overpass.overpasses
                    .filter(NSPredicate(format: "date >= %@", argumentArray: [currentDate]))
                    .sorted(byKeyPath: "date", ascending: true)
                    .toArray()
            case .Past:
                overpassArray = overpass.overpasses
                    .filter(NSPredicate(format: "date < %@", argumentArray: [currentDate]))
                    .sorted(byKeyPath: "date", ascending: false)
                    .toArray()
        }
        
        overpassArray.forEach { overpass in
            let cloudyModel = cloudy.first(where: { (overpass.satellite == $0.satellite) && (overpass.date == $0.endPositionDate) })
            let model = OverpassCellModel(overpass: overpass, cloudy: cloudyModel)
            cellModels.append(model)
        }
        
        self.frequency = overpass.frequency
        self.changed.onNext(())
    }
}
