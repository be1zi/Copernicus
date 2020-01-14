//
//  CloudyViewController.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 14/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import UIKit

public class CloudyViewController: BaseViewController {
    
    //
    // MARK: - Properties
    //
    
    private let viewModel = CloudyViewModel()
    
    //
    // MARK: - Lifecycle
    //
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //
    // MARK: - Appearance
    //
    
    public override func shouldHideNavigationBar() -> Bool {
        return true
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}
