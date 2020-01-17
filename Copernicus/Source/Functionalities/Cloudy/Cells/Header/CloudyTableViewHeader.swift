//
//  CloudyTableViewHeader.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 15/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import UIKit

public class CloudyTableViewHeader: UITableViewHeaderFooterView {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var satelliteLabel: UILabel!
    @IBOutlet weak var cloudyLabel: UILabel!
    @IBOutlet weak var topSeparator: UIView!
    @IBOutlet weak var leftSeparator: UIView!
    @IBOutlet weak var rightSeparator: UIView!
    @IBOutlet weak var bottomSeparator: UIView!
    @IBOutlet weak var backgroundContentView: UIView!
    
    //
    // MARK: - Appearance
    //
    
    private func setStyle() {
        backgroundContentView.backgroundColor = UIColor.copBlackColor
        
        topSeparator.backgroundColor = UIColor.copYellowColor
        leftSeparator.backgroundColor = UIColor.copYellowColor
        rightSeparator.backgroundColor = UIColor.copYellowColor
        bottomSeparator.backgroundColor = UIColor.copYellowColor
    }
    
    //
    // MARK: - Data
    //
    
    public func setViewModel(_ vm: CloudyTableViewHeaderViewModel) {
        titleLabel.text = vm.title
        satelliteLabel.text = vm.satellite
        dateLabel.text = vm.date
        cloudyLabel.text = vm.cloudy
        
        setStyle()
    }
}
