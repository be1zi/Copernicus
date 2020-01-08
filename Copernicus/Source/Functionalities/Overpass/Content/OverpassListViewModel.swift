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
    
    public var overpass: OverpassModel?
    public let changed = ReplaySubject<Void>.create(bufferSize: 1)
    private let overpassData = OverpassData()
    public var cellNumber = 0
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
        
        OverpassRepository.sharedInstance.getOverpassObservable(data: overpassData, type: cellType).subscribe(onNext: { [unowned self] overpasses in
            if let overpass = overpasses.first {
                self.overpass = overpass
                self.cellNumber = overpass.overpasses.count
                self.frequency = overpass.frequency
                self.changed.onNext(())
            }
        }).disposed(by: disposeBag)
    }
}
