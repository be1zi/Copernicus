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
    
    private let viewModel = SettingsViewModel()
    private let disposeBag = DisposeBag()
    
    //
    // MARK: - Lifecycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupRx()
    }
    
    //
    // MARK: - Appearance
    //
    
    private func setupView() {
        contentView.backgroundColor = UIColor.copBlackColor
        saveButton.backgroundColor = UIColor.copYellowColor
    }
    
    override func shouldHideNavigationBar() -> Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    //
    // MARK: - Action
    //
    
    private func setupRx() {
        backButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
    }
    
}
