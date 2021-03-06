//
//  BaseViewController.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 16/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import UIKit

public enum NavigationBarStyle {
    case whiteContent
    case yellowContent
}

public class BaseViewController: UIViewController {
    
    //
    // MARK: - Properties
    //
    
    public lazy var keyboardObserver: KeyboardObserver = {
       return KeyboardObserver()
    }()
    
    //
    // MARK: - Lifecycle
    //
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        loadConfigurations()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadConfigurations()
    }
    
    //
    // MARK: - Methods
    //
    
    private func loadConfigurations() {
        
        self.navigationController?.setNavigationBarHidden(shouldHideNavigationBar(), animated: true)
        
        let backButton = UIBarButtonItem()
        backButton.tintColor = UIColor.black
        navigationItem.backBarButtonItem = backButton
        
        self.title = navigationBarTitle()
    
        navigationController?.navigationItem.setHidesBackButton(shouldHideBackButton(), animated: true)
        
        switch navigationBarStyle() {
        case .whiteContent:
            navigationController?.navigationBar.barTintColor = UIColor.white
        case .yellowContent:
            navigationController?.navigationBar.barTintColor = UIColor.copYellowColor
        }
    }
    
    public func navigationBarTitle() -> String? {
        return nil
    }
    
    public func shouldHideNavigationBar() -> Bool {
        return false
    }
    
    public func shouldHideBackButton() -> Bool {
        return false
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    public func navigationBarStyle() -> NavigationBarStyle {
        return .whiteContent
    }
    
    //
    // MARK: - Alerts
    //
    
    public func showAlert(title: String? = nil, message: String? = nil, buttonTitle: String? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
}
