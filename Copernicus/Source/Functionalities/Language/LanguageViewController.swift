//
//  LanguageViewController.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 16/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LanguageViewController: BaseViewController {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var polishButton: COPButton!
    @IBOutlet weak var englishButton: COPButton!
    
    private let viewModel = LanguageViewModel()
    private let disposeBag = DisposeBag()
    
    //
    // MARK: - Appearance
    //
    
    override func shouldHideBackButton() -> Bool {
        return true
    }
    
    override func shouldHideNavigationBar() -> Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //
    // MARK: - Lifecycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        setupRx()
    }
    
    //
    // MARK: - Methods
    //
    
    private func setData() {
        infoLabel.text = viewModel.infoMessage
        polishButton.setTitle(viewModel.polishButtonTitle, for: .normal)
        englishButton.setTitle(viewModel.englishButtonTitle, for: .normal)
    }
    
    //
    // MARK: - Action
    //
    
    private func setupRx() {
        polishButton.rx.tap.subscribe(onNext: { _ in
            LanguageManager.sharedInstance.currentLanguage = Language.pl.value()
        }).disposed(by: disposeBag)
        
        englishButton.rx.tap.subscribe(onNext: { _ in
            LanguageManager.sharedInstance.currentLanguage = Language.en.value()
        }).disposed(by: disposeBag)
        
        Observable.merge(polishButton.rx.tap.asObservable(),
                                 englishButton.rx.tap.asObservable())
            .subscribe(onNext: { _ in
                
                if AppDelegate.sharedInstance.shouldSkipWalkthrough {
                    AppDelegate.sharedInstance.windowController?.presentLocationController()
                } else {
                    AppDelegate.sharedInstance.windowController?.presentWalkthroughController()
                }
                
        }).disposed(by: disposeBag)
    }
}
