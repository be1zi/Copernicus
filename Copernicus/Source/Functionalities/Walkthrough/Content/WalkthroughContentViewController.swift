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
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    private var viewModel: WalkthroughContentViewModel?
    
    //
    // MARK: - Appearance
    //

    override public func shouldHideBackButton() -> Bool {
        return true
    }
    
    override public func shouldHideNavigationBar() -> Bool {
        return true
    }
    
    //
    // MARK: - Lifecycle
    //
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setupView()
    }
    
    //
    // MARK: - Data
    //
    
    public func setViewModel(_ viewModel: WalkthroughContentViewModel) {
        self.viewModel = viewModel
    }
    
    //
    // MARK: - Methods
    //
    
    private func setupView() {
        backgroundImageView.image = viewModel?.backgroundImage
        numberLabel.text = viewModel?.numberString
        appNameLabel.text = viewModel?.appName
        infoLabel.text = viewModel?.description
    }
    
    private func setStyle() {
        infoLabel.tintColor = UIColor.copGreyColor
    }
}
