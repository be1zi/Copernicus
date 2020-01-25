//
//  ImageryRepository.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 15/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RxSwift
import Moya

public class ImageryRepository {
    
    //
    // MARK: - Properties
    //
    
    public static let sharedInstance = ImageryRepository()
    private let provider = MoyaProvider<ImageryRemoteRepository>()
    private let disposeBag = DisposeBag()
    
    //
    // MARK: - Methods
    //
    
    private func getRequest(_ cloudyData: CloudyData, forPage: Int) -> Single<Response> {
        return provider.rx.request(.imagery(cloudyData, page: forPage))
    }
    
    public func getImageryObservable(_ cloudyData: CloudyData) -> Observable<[ImageryResultModel]> {
        
        if SynchroManager.sharedInstance.shouldSynchronize(type: ImageryResultModel.self) {
        
            provider.rx.request(.imagery(cloudyData, page: 1)).map { [weak self] response in
                guard let self = self else { return }
                
                guard let data = try? JSONSerialization.jsonObject(with: response.data, options: []) as? [String: Any] else {
                    return
                }
                
                guard let total_pages = data["total_pages"] as? Int else {
                    return
                }
                
                if total_pages < 2 {
                    ImageryLocalRepository.sharedInstance.saveImagery(jsonResponse: response)
                    return
                }
                
                let tmp = Array(1...total_pages).map { self.getRequest(cloudyData, forPage: $0).asObservable() }
                var responses = [Response]()
                Observable.merge(tmp).subscribe(onNext: { r in
                    responses.append(r)
                    }, onCompleted: {
                        ImageryLocalRepository.sharedInstance.saveImageryArray(responses)
                        SynchroManager.sharedInstance.synchronized(type: ImageryResultModel.self)
                }).disposed(by: self.disposeBag)
            }
            .subscribe()
            .disposed(by: disposeBag)
        }
        
        return ImageryLocalRepository.sharedInstance.imageryObservable()
    }
    
    public func getImagesForImageryObservable(withId id: Int) -> Observable<[ImageModel]> {
  
        if SynchroManager.sharedInstance.shouldSynchronize(type: ImageModel.self) {
        
            provider.rx.request(.filesList(id)).map { response in
                ImageryLocalRepository.sharedInstance.saveImageArray(forImageId: id, jsonResponse: response)
                SynchroManager.sharedInstance.synchronized(type: ImageModel.self)
            }
            .subscribe()
            .disposed(by: disposeBag)
        }
            
        return ImageryLocalRepository.sharedInstance.imagesObservable(withId: id)
    }
}
