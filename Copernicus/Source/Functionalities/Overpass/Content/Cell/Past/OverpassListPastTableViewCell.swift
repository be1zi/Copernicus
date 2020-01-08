//
//  OverpassListPastTableViewCell.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 08/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import UIKit

public class OverpassListPastTableViewCell: UITableViewCell {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var satelliteNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cloudsValueLabel: UILabel!
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var agoSeparatorLabel: UILabel!
    @IBOutlet weak var cloudsNameLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    //
    // MARK: - Appearance
    //
    
    private func setupView() {
        imageLabel.textColor = UIColor.copGreyColor
        agoSeparatorLabel.textColor = UIColor.copGreyColor
        cloudsNameLabel.textColor = UIColor.copGreyColor
        separatorView.backgroundColor = UIColor.red
    }
    
    //
    // MARK: - Data
    //
    
    public func setViewModel(_ viewModel: OverpassListPastViewModel) {
        
        satelliteNameLabel.text = viewModel.satellite
        timeLabel.text = viewModel.time
        cloudsValueLabel.text = viewModel.cloudsValue
        imageLabel.text = viewModel.imageName
        agoSeparatorLabel.text = viewModel.agoSeparator
        cloudsNameLabel.text = viewModel.clouds
        
        setupView()
    }
}
