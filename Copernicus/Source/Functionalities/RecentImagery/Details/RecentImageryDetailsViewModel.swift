//
//  RecentImageryDetailsViewModel.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 20/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RxSwift

public class RecentImageryDetailsViewModel {
    
    //
    // MARK: - Properties
    //
    
    public let cellIdentifier = String(describing: RecentImageryDetailsTableViewCell.self)
    
    private let imageryId: Int
    private let disposeBag = DisposeBag()
    public var imageModels = [ImageModel]()
    
    public var shouldReload = ReplaySubject<Void>.create(bufferSize: 1)
    public var rowNumber: Int {
        get {
            return imageModels.count
        }
    }
    public var basePath: String?
    
    //
    // MARK: - Init
    //
    
    public init(imageryId: Int) {
        self.imageryId = imageryId
        self.getImagesList()
    }
    
    //
    // MARK: - Data
    //
    
    public func getImagesList() {
        if imageryId < 0 { return }
        
        ImageryRepository.sharedInstance.getImagesForImageryObservable(withId: imageryId).subscribe(onNext: { [unowned self] images in
            self.imageModels = images
            self.prepareData()
        }).disposed(by: disposeBag)
    }
    
    public func prepareData() {
        
        guard let address = ConfigurationManager.sharedInstance.serverAddress else {
            return
        }
        
        basePath = "\(address)/imagery/\(imageryId)/files/"
        
        shouldReload.onNext(())
    }
}
