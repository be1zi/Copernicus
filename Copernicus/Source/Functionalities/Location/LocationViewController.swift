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
    
    private let viewModel = LocationViewModel()
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
        return .darkContent
    }
    
    private func setupView() {
        languageButton.backgroundColor = UIColor.copYellowColor
        infoLabel.textColor = UIColor.copGreyColor
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
        
        skipButton.rx.tap.subscribe(onNext: {
            AppDelegate.sharedInstance.windowController?.presentHomeController()
        }).disposed(by: disposeBag)
        
        languageButton.rx.tap.subscribe(onNext: {
            AppDelegate.sharedInstance.windowController?.presentLanguageController()
        }).disposed(by: disposeBag)
    }
}
