//
//  OverpassListViewModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 04/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//
import RxSwift

public enum OverpassCellType {
    case Future
    case Past
}

public class OverpassListViewModel {
    
    //
    // MARK: - Properties
    //
    
    public let cellIdentifiers = [String(describing: OverpassListFutureTableViewCell.self),
                                  String(describing: OverpassListPastTableViewCell.self)]
    public let headerIdentifier = String(describing: OverpassListHeaderTableViewCell.self)
    
    public let changed = ReplaySubject<Void>.create(bufferSize: 1)
    public var overpasses: [SingleOverpassModel] = []
    private let overpassData = OverpassData()
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
        
        OverpassRepository.sharedInstance.getOverpassObservable(data: overpassData).subscribe(onNext: { [unowned self] overpasses in
            self.setData(overpasses)
        }).disposed(by: disposeBag)
    }
    
    private func setData(_ overpasses: [OverpassModel]) {
        guard let overpass = overpasses.first else { return }
        
        switch cellType {
            case .Future:
                self.overpasses = overpass.overpasses
                    .filter(NSPredicate(format: "date >= %@", argumentArray: [Date()]))
                    .sorted(byKeyPath: "date", ascending: true)
                    .toArray()
            case .Past:
                self.overpasses = overpass.overpasses
                    .filter(NSPredicate(format: "date < %@", argumentArray: [Date()]))
                    .sorted(byKeyPath: "date", ascending: false)
                    .toArray()
        }

        self.frequency = overpass.frequency
        self.changed.onNext(())
    }
}
