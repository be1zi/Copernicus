//
//  ImageryRepository.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 15/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RxSwift
import Moya

public struct ImageryRepository {
    
    //
    // MARK: - Properties
    //
    
    public static let sharedInstance = ImageryRepository()
    private let provider = MoyaProvider<ImageryRemoteRepository>()
    private let disposeBag = DisposeBag()
    
    //
    // MARK: - Methods
    //
    
    public func getImageryObservable(_ cloudyData: CloudyData) -> Observable<[ImageryResultModel]> {
                
        provider.rx.request(.imagery(cloudyData)).map { response in
            ImageryLocalRepository.sharedInstance.saveImagery(jsonResponse: response)
        }
        .subscribe()
        .disposed(by: disposeBag)
        
        return ImageryLocalRepository.sharedInstance.imageryObservable()
    }
}
