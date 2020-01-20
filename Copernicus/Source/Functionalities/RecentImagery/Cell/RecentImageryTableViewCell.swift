//
//  RecentImageryTableViewCell.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 20/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import UIKit

public class RecentImageryTableViewCell: UITableViewCell {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var satelliteLabel: UILabel!

    //
    // MARK: - Data
    //
    
    public func setViewModel(_ viewModel: RecentImageryTableViewCellViewModel) {
        dateLabel.text = viewModel.date
        satelliteLabel.text = viewModel.satellite
    }
}
