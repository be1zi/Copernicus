//
//  BaseViewController.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 16/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    //
    // MARK: - Lifecycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadConfigurations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadConfigurations()
    }
    
    //
    // MARK: - Methods
    //
    
    private func loadConfigurations() {
        
        self.navigationController?.setNavigationBarHidden(shouldHideNavigationBar(), animated: true)
        
        let backButton = UIBarButtonItem()
        navigationItem.backBarButtonItem = backButton
        
        self.title = navigationBarTitle()
        
        navigationController?.navigationItem.setHidesBackButton(shouldHideBackButton(), animated: true)
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
}
