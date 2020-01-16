//
//  CloudyTableViewCell.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 15/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import UIKit

public class CloudyTableViewCell: UITableViewCell {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var leftSeparator: UIView!
    @IBOutlet weak var rightSeparator: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var satelliteLabel: UILabel!
    @IBOutlet weak var cloudyLabel: UILabel!
    
}
