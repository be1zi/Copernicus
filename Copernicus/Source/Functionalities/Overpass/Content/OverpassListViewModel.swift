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
    
    public let cellIdentifier = String(describing: OverpassListFutureTableViewCell.self)
    public var overpass: OverpassModel?
    public let changed = ReplaySubject<Void>.create(bufferSize: 1)
    private let overpassData = OverpassData()
    public var cellNumber = 0
    
    private let disposeBag = DisposeBag()
    
    //
    // MARK: - Init
    //
    
    public init() {
        getData()
    }
    
    //
    // MARK: - Data
    //

    private func getData() {
        
        OverpassRepository.sharedInstance.getOverpassObservable(data: overpassData).subscribe(onNext: { [unowned self] overpasses in
            if let overpass = overpasses.first {
                self.overpass = overpass
                self.cellNumber = overpass.overpasses.count
                self.changed.onNext(())
            }
        }).disposed(by: disposeBag)
    }
}
