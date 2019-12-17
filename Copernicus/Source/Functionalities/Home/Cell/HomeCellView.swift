//
//  HomeCellView.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 17/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import UIKit

class HomeCellView: UICollectionViewCell {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private var viewModel: HomeCellViewModel?
    
    //
    // MARK: - Methods
    //
    
    public func setViewModel(_ viewModel: HomeCellViewModel) {
        self.viewModel = viewModel
        
        setData()
    }
    
    private func setData() {
        
        guard let viewModel = viewModel else { return }
        
        iconImageView.image = viewModel.image
        titleLabel.text = viewModel.title
    }
}
