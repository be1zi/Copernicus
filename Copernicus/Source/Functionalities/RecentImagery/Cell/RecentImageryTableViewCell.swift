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

    private var viewModel: RecentImageryTableViewCellViewModel?
    
    //
    // MARK: - Data
    //
    
    public func setViewModel(_ vm: RecentImageryTableViewCellViewModel) {
        viewModel = vm
        dateLabel.text = vm.date
        satelliteLabel.text = vm.satellite
    }
    
    public func getImageId() -> Int {
        guard let vm = viewModel else { return -1 }
        
        return vm.image
    }
}
