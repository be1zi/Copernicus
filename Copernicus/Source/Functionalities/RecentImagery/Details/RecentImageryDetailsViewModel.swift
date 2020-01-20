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
    
    private let imageryId: Int
    private let disposeBag = DisposeBag()
    
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
            print(images.count)
        }).disposed(by: disposeBag)
    }
}
