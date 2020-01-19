//
//  SettingsViewModel.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 20/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import RxSwift

public class SettingsViewModel {
    
    //
    // MARK: - Properties
    //
    
    public var title: String?
    public var subtitle: String?
    public var locationTitle: String?
    public var dataTitle: String?
    public var notificationsTitle: String?
    public var gpsTitle: String?
    public var clearDataTitle: String?
    public var clearDataButton: String = ""
    public var notificationsInfo: String?
    public var changeLocation: String = ""
    public var changeGpsPermission: String = ""
    public var locationValue = BehaviorSubject<String>(value: "")
    
    private let disposeBag = DisposeBag()
    
    
    //
    // MARK: Init
    //
    
    public init() {
        setStaticData()
        getCurrentLocation()
    }
    
    //
    // MARK: - Data
    //
    
    private func setStaticData() {
        self.title = "settings.title".localized()
        self.subtitle = "settings.subtitle".localized()
        self.locationTitle = "settings.content.location.title".localized()
        self.gpsTitle = "settings.content.location.gps".localized()
        self.dataTitle = "settings.content.data.title".localized()
        self.clearDataTitle = "settings.content.data.clear".localized()
        self.notificationsTitle = "settings.content.notifications.title".localized()
        self.notificationsInfo = "settings.content.notifications.info".localized()
        
        self.changeLocation = "  \("button.change.title".localized())  "
        self.changeGpsPermission = "  \("button.change.title".localized())  "
        self.clearDataButton = "  \("button.clear.title".localized())  "
    }
    
    private func getCurrentLocation() {
        
        LocationRepository.sharedInstance.getLocationObservable().subscribe(onNext: { [unowned self] locations in
            guard let location = locations.first else { return }
            self.setData(location: location)
        }).disposed(by: disposeBag)
    }
    
    private func setData(location: LocationModel) {
        var value = ""
        
        if location.exist() == true {
            value = location.toString()
        } else {
            value = "settings.content.location.notChoosed".localized()
        }

        locationValue.onNext(value)
    }
    
    public func deleteData() {
        LocalRepository.sharedInstance.clearDatabase()
    }
}
