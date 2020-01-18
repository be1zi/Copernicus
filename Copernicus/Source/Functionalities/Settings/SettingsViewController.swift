//
//  SettingsViewController.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 20/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import UIKit
import RxSwift

class SettingsViewController: BaseViewController {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var locationTitleLabel: UILabel!
    @IBOutlet weak var locationValueLabel: UILabel!
    @IBOutlet weak var changeLocationButton: UIButton!
    @IBOutlet weak var gpsLabel: UILabel!
    @IBOutlet weak var gpsSettingsButton: UIButton!
    @IBOutlet weak var dataTitleLabel: UILabel!
    @IBOutlet weak var clearDataLabel: UILabel!
    @IBOutlet weak var clearDataSwitch: UISwitch!
    @IBOutlet weak var notificationTitleLabel: UILabel!
    @IBOutlet weak var notificationInfoLabel: UILabel!
    
    
    private let viewModel = SettingsViewModel()
    private let disposeBag = DisposeBag()
    
    //
    // MARK: - Lifecycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupRx()
        setData()
    }
    
    //
    // MARK: - Appearance
    //
    
    private func setupView() {
        contentView.backgroundColor = UIColor.copBlackColor
        saveButton.backgroundColor = UIColor.copYellowColor
        notificationInfoLabel.textColor = UIColor.copBlueColor
        clearDataSwitch.onTintColor = UIColor.copYellowColor
        
        clearDataSwitch.isOn = false
        
        changeLocationButton.backgroundColor = UIColor.copYellowColor
        changeLocationButton.cornerRadius = changeLocationButton.bounds.height / 2.0
        
        gpsSettingsButton.backgroundColor = UIColor.copYellowColor
        gpsSettingsButton.cornerRadius = gpsSettingsButton.bounds.height  / 2.0
    }
    
    override func shouldHideNavigationBar() -> Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    //
    // MARK: - Data
    //
    
    private func setData() {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        
        locationTitleLabel.text = viewModel.locationTitle
        gpsLabel.text = viewModel.gpsTitle
        dataTitleLabel.text = viewModel.dataTitle
        clearDataLabel.text = viewModel.clearDataTitle
        notificationTitleLabel.text = viewModel.notificationsTitle
        notificationInfoLabel.text = viewModel.notificationsInfo
        
        changeLocationButton.setTitle(viewModel.changeLocation, for: .normal)
        gpsSettingsButton.setTitle(viewModel.changeGpsPermission, for: .normal)
        saveButton.setTitle(viewModel.saveButton, for: .normal)
    }
    
    //
    // MARK: - Action
    //
    
    private func setupRx() {
        backButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.locationValue.subscribe(onNext: { [weak self] value in
            self?.locationValueLabel.text = value
        }).disposed(by: disposeBag)
    }
}
