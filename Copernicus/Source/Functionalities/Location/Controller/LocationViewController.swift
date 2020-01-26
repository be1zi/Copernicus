//
//  LocationViewController.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 02/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import UIKit
import RxSwift

public class LocationViewController: BaseViewController {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var countryTextField: COPTextField!
    @IBOutlet weak var cityTextField: COPTextField!
    @IBOutlet weak var streetTextField: COPTextField!
    @IBOutlet weak var houseNumberTextField: COPTextField!
    @IBOutlet weak var zipCodeTextField: COPTextField!
    
    @IBOutlet weak var saveButton: COPButton!
    @IBOutlet weak var skipButton: COPButton!
    @IBOutlet weak var languageButton: UIButton!
    
    @IBOutlet weak var constraintToBottom: NSLayoutConstraint!
    
    @IBOutlet var contentView: UIView!
    
    private var viewModel = LocationViewModel()
    private let disposeBag = DisposeBag()
    
    //
    // MARK: - Lifecycle
    //
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFields()
        setupView()
        setData()
        setupRx()
    }
    
    //
    // MARK: - Appearance
    //
    
    override public func shouldHideNavigationBar() -> Bool {
        return true
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setupView() {
        languageButton.backgroundColor = UIColor.copYellowColor
        infoLabel.textColor = UIColor.copBlueColor
        contentView.backgroundColor = UIColor.copBlackColor
    }
    
    //
    // MARK: - Data
    //
    
    private func setData() {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        infoLabel.text = viewModel.info
        
        saveButton.setTitle(viewModel.saveButtonTitle, for: .normal)
        skipButton.setTitle(viewModel.skipButtonTitle, for: .normal)
        languageButton.setTitle(viewModel.selectedLanguage, for: .normal)
    }
    
    private func setupTextFields() {
        countryTextField.placeholder = viewModel.country
        cityTextField.placeholder = viewModel.city
        streetTextField.placeholder = viewModel.street
        houseNumberTextField.placeholder = viewModel.houseNumber
        zipCodeTextField.placeholder = viewModel.zipCode
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
        
        skipButton.rx.tap.subscribe(onNext: {
            AppDelegate.sharedInstance.windowController?.presentHomeController()
            AppDelegate.sharedInstance.shouldSkipToHome = true
        }).disposed(by: disposeBag)
        
        saveButton.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            
            self.viewModel.saveLocation().subscribe(onSuccess: { _ in
                  AppDelegate.sharedInstance.windowController?.presentHomeController()
                  AppDelegate.sharedInstance.shouldSkipToHome = true
            }) { error in
                Logger.logError(error: error)
                self.showAlert(title: "alert.title".localized(),
                               message: "alert.location.message".localized(),
                               buttonTitle: "button.cancel.title".localized() )
            }.disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
        
        languageButton.rx.tap.subscribe(onNext: {
            AppDelegate.sharedInstance.windowController?.presentLanguageController()
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
}
