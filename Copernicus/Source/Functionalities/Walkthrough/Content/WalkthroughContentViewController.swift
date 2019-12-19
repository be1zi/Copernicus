//
//  WalkthroughContentViewController.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 18/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import UIKit

public class WalkthroughContentViewController: BaseViewController {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    
    private var data: WalkthroughData?
    
    //
    // MARK: - Lifecycle
    //
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    //
    // MARK: - Data
    //
    
    public func setData(_ data: WalkthroughData) {
        self.data = data
    }
    
    //
    // MARK: - Appearance
    //
    
    private func setupView() {
        backgroundImageView.image = data?.backgroundImage
        numberLabel.text = data?.numberString
    }

    override public func shouldHideBackButton() -> Bool {
        return true
    }
    
    override public func shouldHideNavigationBar() -> Bool {
        return true
    }
}
