//
//  SettingsViewModel.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 20/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

public struct SettingsViewModel {
    
    //
    // MARK: - Properties
    //
    
    public var title: String?
    public var subtitle: String?
    public var saveButton: String = ""
    public var locationTitle: String?
    public var dataTitle: String?
    public var notificationsTitle: String?
    public var gpsTitle: String?
    public var clearDataTitle: String?
    public var notificationsInfo: String?
    public var changeLocation: String = ""
    public var changeGpsPermission: String = ""
    
    //
    // MARK: Init
    //
    
    public init() {
        self.setStaticData()
    }
    
    //
    // MARK: - Data
    //
    
    private mutating func setStaticData() {
        self.title = "settings.title".localized()
        self.subtitle = "settings.subtitle".localized()
        self.saveButton = "button.save.title".localized()
        self.locationTitle = "settings.content.location.title".localized()
        self.gpsTitle = "settings.content.location.gps".localized()
        self.dataTitle = "settings.content.data.title".localized()
        self.clearDataTitle = "settings.content.data.clear".localized()
        self.notificationsTitle = "settings.content.notifications.title".localized()
        self.notificationsInfo = "settings.content.notifications.info".localized()
        
        self.changeLocation = "  \("button.change.title".localized())  "
        self.changeGpsPermission = "  \("button.change.title".localized())  "
    }
}
