//
//  CloudyTableViewFooter.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 15/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import UIKit

public class CloudyTableViewFooter: UITableViewHeaderFooterView {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var cloudyLabel: UILabel!
    @IBOutlet weak var backgroundContentView: UIView!
    
    //
    // MARK: - Appearance
    //
    
    private func setStyle() {
        separatorView.backgroundColor = UIColor.copYellowColor
        backgroundContentView.backgroundColor = UIColor.copBlackColor
    }
    
    //
    // MARK: - Data
    //
    
    public func setViewModel(_ vm: CloudyTableViewFooterViewModel) {
        cloudyLabel.text = vm.cloudy
        
        setStyle()
    }
}
