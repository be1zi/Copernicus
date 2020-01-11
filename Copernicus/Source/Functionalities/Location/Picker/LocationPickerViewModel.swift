//
//  LocationPickerViewModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 11/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import RxSwift
import CoreLocation

public struct LocationPickerViewModel {
    
    //
    // MARK: - Properties
    //
    
    public var title: String?
    
    public var country: String?
    public var city: String?
    public var street: String?
    public var houseNumber: String?
    public var zipCode: String?
    
    public var useMyLocationTitle: String?
    public var saveAsDefaultTitle: String?
    
    public var saveButton = ""
    public var cancelButton = ""
    
    private var locationData = LocationData(type: .Temporary)
    
    //
    // MARK: - Init
    //
    
    public init() {
        self.setupData()
    }
    
    //
    // MARK: - Prepare data
    //
    
    private mutating func setupData() {
        self.title = "location.picker.title".localized()
        
        self.country = "location.textfield.country.placeholder".localized()
        self.city = "location.textfield.city.placeholder".localized()
        self.street = "location.textfield.street.placeholder".localized()
        self.houseNumber = "location.textfield.houseNumber.placeholder".localized()
        self.zipCode = "location.textfield.zipCode.placeholder".localized()
        
        self.saveAsDefaultTitle = "location.picker.useAsDefault".localized()
        self.useMyLocationTitle = "location.picker.useMylocation".localized()
        
        self.saveButton = "button.save.title".localized().uppercased()
        self.cancelButton = "button.cancel.title".localized().uppercased()
    }
    
    //
    // MARK: - Set data
    //
    
    public mutating func setData(newValue: String?, type: LocationFieldType) {
        
        switch type {
        case .country:
            locationData.country = newValue
        case .city:
            locationData.city = newValue
        case .street:
            locationData.street = newValue
        case .houseNumber:
            locationData.houseNumber = newValue
        case .zipCode:
            locationData.zipCode = newValue
        }
    }
    
    public mutating func saveAsDefaultChanged(_ newValue: Bool) {
        locationData.saveAsDefault = newValue
    }
    
    public mutating func setMyLocation(_ placemark: CLPlacemark) {
        
        setData(newValue: placemark.country, type: .country)
        setData(newValue: placemark.postalCode, type: .zipCode)
        setData(newValue: placemark.locality, type: .city)
        setData(newValue: placemark.thoroughfare, type: .street)
    }
    
    //
    // MARK: - Action
    //
    
    public func saveLocation() -> Single<Void> {
        return LocationLocalRepository.sharedInstance.saveLocation(locationData)
    }
}