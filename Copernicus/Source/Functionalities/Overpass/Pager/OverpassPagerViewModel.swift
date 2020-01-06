//
//  OverpassPagerViewModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 05/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import UIKit
import RxSwift

public class OverpassPagerViewModel {
    
    //
    // MARK: - Properties
    //
    
    private var pageViewControllers: [BaseViewController] = []
    private var titles = [String]()
    private let disposeBag = DisposeBag()
    
    public let segue = "OverpassListView"
    public var title: String?
    public var subtitle: String?
    public var changeButton: String = ""
    public var controllersNumber: Int {
        get {
            return pageViewControllers.count
        }
    }
    
    public let location = ReplaySubject<LocationModel>.create(bufferSize: 1)
    private var locationSelected: Bool = false
    public var locationString = ""
    
    //
    // MARK: - Lifecycle
    //
    
    public init() {
        createViewControllers()
        setStaticProperties()
        getCurrentLocation()
    }
    
    //
    // MARK: - Prepare data
    //
    
    private func createViewControllers() {
        let vc = UIStoryboard.init(name: segue, bundle: nil).instantiateInitialViewController() as? BaseViewController
        
        if let viewController = vc {
            pageViewControllers.append(viewController)
        }
        
        let vc2 = UIStoryboard.init(name: segue, bundle: nil).instantiateInitialViewController() as? BaseViewController
        
        if let viewController2 = vc2 {
            pageViewControllers.append(viewController2)
        }
    }
    
    private func setStaticProperties() {
        self.title = "overpass.pager.title".localized()
        self.subtitle = "overpass.pager.selectedLocation.title".localized()
        self.changeButton = "button.change.title".localized()
        self.titles = ["overpass.pager.leftItem".localized(), "overpass.pager.rightItem".localized()]
        
        setLocationData()
    }
    
    private func getCurrentLocation() {
        
        LocationRepository.sharedInstance.getLocationObservable().subscribe(onNext: { [unowned self] location in
            self.location.onNext(location)
            self.locationSelected = location.exist()
            self.setLocationData(location)
        }).disposed(by: disposeBag)
    }
    
    private func setLocationData(_ loc: LocationModel? = nil) {
        if locationSelected {
            locationString = loc?.toString() ?? ""
        } else {
            locationString = "overpass.pager.selectedLocation.notChoosed".localized()
        }
    }
    
    //
    // MARK: - Get data
    //
    
    public func viewController(atIndex index: Int) -> BaseViewController {
        return pageViewControllers[index]
    }
    
    public func viewForController(atIndex index: Int) -> UIView {
        return pageViewControllers[index].view
    }
    
    public func titleForController(atIndex index: Int) -> String {
        return titles[index]
    }
}
