//
//  RecentImageryDetailsTableViewCell.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 20/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import UIKit
import Kingfisher

public class RecentImageryDetailsTableViewCell: UITableViewCell {
 
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var cloudyImageView: UIImageView!
    
    //
    // MARK: - Data
    //
    
    public func setViewModel(_ vm: RecentImageryDetailsTableViewCellModel) {
        cloudyImageView.kf.indicatorType = .activity
        cloudyImageView.kf.setImage(with: vm.imageURL)
    }
}
