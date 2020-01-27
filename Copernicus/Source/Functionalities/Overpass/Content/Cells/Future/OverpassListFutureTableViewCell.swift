//
//  OverpassListFutureTableViewCell.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 06/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import UIKit

public class OverpassListFutureTableViewCell: UITableViewCell {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var inSeparatorLabel: UILabel!
    @IBOutlet weak var imaginingLabel: UILabel!
    @IBOutlet weak var overpassLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imaginingValueLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    //
    // MARK: - Appearance
    //
    
    private func setupView() {
        separatorView.backgroundColor = UIColor.red
    }
    
    //
    // MARK: - Data
    //
    
    public func setViewModel(_ viewModel: OverpassListFutureViewModel) {
        nameLabel.text = viewModel.name
        inSeparatorLabel.text = viewModel.inSeparator
        imaginingLabel.text = viewModel.imagining
        overpassLabel.text = viewModel.overpassName
        timeLabel.text = viewModel.time
        imaginingValueLabel.text = viewModel.imaginingValue
        
        setupView()
    }
}
