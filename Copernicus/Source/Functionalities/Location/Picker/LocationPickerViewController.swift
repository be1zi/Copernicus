//
//  LocationPickerViewController.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 11/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import UIKit
import RxSwift
import CoreLocation

public class LocationPickerViewController: BaseViewController {
    
    //
    // MARK: - Properties
    //
   
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var countryTextField: COPTextField!
    @IBOutlet weak var cityTextField: COPTextField!
    @IBOutlet weak var streetTextField: COPTextField!
    @IBOutlet weak var houseNumberTextField: COPTextField!
    @IBOutlet weak var zipCodeTextField: COPTextField!
    
    @IBOutlet weak var useMyLocationLabel: UILabel!
    @IBOutlet weak var useMyLocationSwitch: UISwitch!
    @IBOutlet weak var saveAsDefaultLabel: UILabel!
    @IBOutlet weak var saveAsDefaultSwitch: UISwitch!
    @IBOutlet weak var separatorView: UIView!

    @IBOutlet weak var saveButton: COPButton!
    @IBOutlet weak var cancelButton: COPButton!
    
    @IBOutlet weak var constraintToBottom: NSLayoutConstraint!
    
    private var viewModel = LocationPickerViewModel()
    private let disposeBag = DisposeBag()
    private let locationManager = CLLocationManager()

    //
    // MARK: - Lifecycle
    //
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFields()
        setupView()
        setupRx()
        setData()
    }
    
    //
    // MARK: - Appearance
    //
    
    private func setupView() {
        separatorView.backgroundColor = UIColor.copGreyColor
        saveAsDefaultSwitch.onTintColor = UIColor.copYellowColor
        useMyLocationSwitch.onTintColor = UIColor.copYellowColor
        useMyLocationSwitch.isOn = false
        saveAsDefaultSwitch.isOn = false
    }
    
    //
    // MARK: - Data
    //
    
    private func setData() {
        titleLabel.text = viewModel.title
        useMyLocationLabel.text = viewModel.useMyLocationTitle
        saveAsDefaultLabel.text = viewModel.saveAsDefaultTitle
        
        saveButton.setTitle(viewModel.saveButton, for: .normal)
        cancelButton.setTitle(viewModel.cancelButton, for: .normal)
    }
    
    private func setupTextFields() {
        countryTextField.placeholder = viewModel.country
        cityTextField.placeholder = viewModel.city
        streetTextField.placeholder = viewModel.street
        houseNumberTextField.placeholder = viewModel.houseNumber
        zipCodeTextField.placeholder = viewModel.zipCode
    }
    
    private func setDataFromPlacemark(_ placemark: CLPlacemark) {
        countryTextField.text = placemark.country
        cityTextField.text = placemark.locality
        zipCodeTextField.text = placemark.postalCode
        streetTextField.text = placemark.thoroughfare
        houseNumberTextField.text = nil
    }
    
    //
    // MARK: - Actions
    //
    
    private func setupRx() {
        
        setupButtonRx()
        setupTextFieldsChangeValueRx()
        setupTextFieldsReturnButtonRx()
        setupKeyboardRx()
    }
    
    private func setupButtonRx() {
        
        saveButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            
            self.viewModel.saveLocation().subscribe(onSuccess: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            }, onError: { error in
                Logger.logError(error: error)
            }).disposed(by: self.disposeBag)
            
        }).disposed(by: disposeBag)
        
        cancelButton.rx.tap.subscribe(onNext: { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
        
        saveAsDefaultSwitch.rx.isOn.changed.subscribe(onNext: { [ weak self] isOn in
            self?.viewModel.saveAsDefaultChanged(isOn)
        }).disposed(by: disposeBag)
        
        useMyLocationSwitch.rx.isOn.changed.subscribe(onNext: { [weak self] result in
            self?.setupLocationManager()
            self?.setUserInteractionEnabled(!result)
            self?.setTextFieldsBackgroundColor(!result)
        }).disposed(by: disposeBag)
    }
    
    private func setupTextFieldsChangeValueRx() {
        
        countryTextField.rx.value.distinctUntilChanged().subscribe(onNext: { [weak self] newValue in
            self?.viewModel.setData(newValue: newValue, type: .country)
        }).disposed(by: disposeBag)
        
        cityTextField.rx.value.distinctUntilChanged().subscribe(onNext: { [weak self] newValue in
            self?.viewModel.setData(newValue: newValue, type: .city)
        }).disposed(by: disposeBag)
        
        streetTextField.rx.value.distinctUntilChanged().subscribe(onNext: { [weak self] newValue in
            self?.viewModel.setData(newValue: newValue, type: .street)
        }).disposed(by: disposeBag)
        
        houseNumberTextField.rx.value.distinctUntilChanged().subscribe(onNext: { [weak self] newValue in
            self?.viewModel.setData(newValue: newValue, type: .houseNumber)
        }).disposed(by: disposeBag)
        
        zipCodeTextField.rx.value.distinctUntilChanged().subscribe(onNext: { [weak self] newValue in
            self?.viewModel.setData(newValue: newValue, type: .zipCode)
        }).disposed(by: disposeBag)
    }
    
    private func setupTextFieldsReturnButtonRx() {
        countryTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { [weak self] _ in
            self?.countryTextField.resignFirstResponder()
            self?.cityTextField.becomeFirstResponder()
        }).disposed(by: disposeBag)
     
        cityTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { [weak self] _ in
            self?.cityTextField.resignFirstResponder()
            self?.streetTextField.becomeFirstResponder()
        }).disposed(by: disposeBag)
        
        streetTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { [weak self] _ in
            self?.streetTextField.resignFirstResponder()
            self?.houseNumberTextField.becomeFirstResponder()
        }).disposed(by: disposeBag)
        
        houseNumberTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { [weak self] _ in
            self?.houseNumberTextField.resignFirstResponder()
            self?.zipCodeTextField.becomeFirstResponder()
        }).disposed(by: disposeBag)
        
        zipCodeTextField.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: { [weak self] _ in
            self?.zipCodeTextField.resignFirstResponder()
        }).disposed(by: disposeBag)
    }
    
    private func setupKeyboardRx() {
        
        keyboardObserver.didShow.subscribe(onNext: { [weak self] keyboardInfo in
            self?.constraintToBottom.constant = keyboardInfo.frameEnd.height
        }).disposed(by: disposeBag)
        
        keyboardObserver.willHide.subscribe(onNext: { [weak self] keyboardInfo in
            self?.constraintToBottom.constant = 0
        }).disposed(by: disposeBag)
    }
    
    //
    // MARK: - helper
    //
    
    private func setUserInteractionEnabled(_ enabled: Bool) {
        countryTextField.isUserInteractionEnabled = enabled
        cityTextField.isUserInteractionEnabled = enabled
        streetTextField.isUserInteractionEnabled = enabled
        houseNumberTextField.isUserInteractionEnabled = enabled
        zipCodeTextField.isUserInteractionEnabled = enabled
    }
    
    private func setTextFieldsBackgroundColor(_ active: Bool) {
        
        let color = active == true ? UIColor.clear : UIColor.lightGray
        
        countryTextField.backgroundColor = color
        cityTextField.backgroundColor = color
        streetTextField.backgroundColor = color
        houseNumberTextField.backgroundColor = color
        zipCodeTextField.backgroundColor = color
    }
    
    private func setupLocationManager() {
        self.locationManager.requestAlwaysAuthorization()

        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
}

extension LocationPickerViewController: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if useMyLocationSwitch.isOn == false { return }
        
        guard let location = manager.location else { return }
        
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let err = error {
                Logger.logError(error: err)
                return
            }
            
            guard let placemark = placemarks?.first else { return }
            
            //self.viewModel.setMyLocation(placemark)
            self.setDataFromPlacemark(placemark)
        }
    }
}
