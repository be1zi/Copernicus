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

public class OverpassListViewModel {
    
    //
    // MARK: - Properties
    //
    
    public let cellIdentifiers = [OverpassCellType.Future.rawValue,
                                  OverpassCellType.Past.rawValue]
    public let headerIdentifier = String(describing: OverpassListHeaderTableViewCell.self)
    
    public let changed = ReplaySubject<Void>.create(bufferSize: 1)
    public var overpasses: [SingleOverpassModel] = []
    public var cellNumber: Int  {
        get {
            return overpasses.count
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
        getData()
    }
    
    //
    // MARK: - Data
    //

    private func getData() {
        
        LocationRepository.sharedInstance.getLocationObservable().subscribe(onNext: { [unowned self] locations in
            guard let loc = locations.last else { return }
            let overpassData = OverpassData(latitude: loc.latitide, longitude: loc.longitude)
            OverpassRepository.sharedInstance.getOverpassObservable(data: overpassData).subscribe(onNext: { [unowned self] overpasses in
                self.setData(overpasses)
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
    
    private func setData(_ overpasses: [OverpassModel]) {
        guard let overpass = overpasses.first else { return }
        let currentDate = Date()
        
        switch cellType {
            case .Future:
                self.overpasses = overpass.overpasses
                    .filter(NSPredicate(format: "date >= %@", argumentArray: [currentDate]))
                    .sorted(byKeyPath: "date", ascending: true)
                    .toArray()
            case .Past:
                self.overpasses = overpass.overpasses
                    .filter(NSPredicate(format: "date < %@", argumentArray: [currentDate]))
                    .sorted(byKeyPath: "date", ascending: false)
                    .toArray()
        }
        
        self.frequency = overpass.frequency
        self.changed.onNext(())
    }
    
    private func getCloudy() {
        //ImageryRepository.sharedInstance.get
    }
}
