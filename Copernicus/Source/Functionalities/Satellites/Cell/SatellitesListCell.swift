//
//  SatellitesListCell.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 02/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import UIKit

public class SatellitesListCell: UITableViewCell {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var nameLabel: UILabel!
    
    //
    // MARK: - Data
    //
    
    public func setupViewModel(_ viewModel: SatellitesListCellViewModel) {
        nameLabel.text = viewModel.name
    }
}
