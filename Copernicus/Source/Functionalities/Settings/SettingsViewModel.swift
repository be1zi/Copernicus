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
    public var generalTitle: String?
    public var changeLanguageButton: String = ""
    public var locationValue = BehaviorSubject<String>(value: "")
    public var languageValue = BehaviorSubject<String>(value: "")
    
    private let disposeBag = DisposeBag()
    
    
    //
    // MARK: Init
    //
    
    public init() {
        setLocation(location: nil)
        setLanguage(language: nil)
        
        getCurrentLocation()
        getSelectedLanguage()
        setStaticData()
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
        self.generalTitle = "settings.content.general.title".localized()
        
        self.changeLocation = "  \("button.change.title".localized())  "
        self.changeGpsPermission = "  \("button.change.title".localized())  "
        self.clearDataButton = "  \("button.clear.title".localized())  "
        self.changeLanguageButton = "  \("button.change.title".localized())  "
    }
    
    private func getCurrentLocation() {
        
        LocationRepository.sharedInstance.getLocationObservable().subscribe(onNext: { [unowned self] locations in
            self.setLocation(location: locations.first)
        }).disposed(by: disposeBag)
    }
    
    private func getSelectedLanguage() {
        LanguageManager.sharedInstance.currentLanguageObservable().subscribe(onNext: { [unowned self] language in
            self.setLanguage(language: language)
        }).disposed(by: disposeBag)
    }
    
    private func setLocation(location: LocationModel?) {
        var value = ""
        
        guard let loc = location else {
            value = "settings.content.location.notChoosed".localized()
            locationValue.onNext(value)
            return
        }
        
        if loc.exist() == true {
            value = loc.toString()
        } else {
            value = "settings.content.location.notChoosed".localized()
        }

        locationValue.onNext(value)
    }
    
    private func setLanguage(language: String?) {
        var value = "settings.content.general.selectedLanguage".localized()
        
        guard let lang = language else {
            languageValue.onNext(value)
            return
        }
        
        if lang == Language.en.value() {
            value += " \("language.english".localized())"
        } else {
            value += " \("language.polish".localized())"
        }
        
        languageValue.onNext(value)
    }
    
    public func deleteData() {
        LocalRepository.sharedInstance.clearDatabase()
    }
}
