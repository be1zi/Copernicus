//
//  OverpassListHeaderTableViewCell.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 07/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import UIKit

public class OverpassListHeaderTableViewCell: UITableViewHeaderFooterView {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var frequencyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    //
    // MARK: - Data
    //
    
    public func setViewModel(_ viewModel: OverpassListHeaderViewModel) {
        frequencyLabel.text = viewModel.frequencyName
        valueLabel.text = viewModel.frequency
    }
}
