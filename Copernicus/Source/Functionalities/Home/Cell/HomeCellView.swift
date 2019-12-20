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
    @IBOutlet weak var content: UIView!
    
    public var viewModel: HomeCellViewModel?
    
    //
    // MARK: - Lifecycle
    //
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setStyle()
    }
    
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
    
    private func setStyle() {
        titleLabel.textColor = UIColor.copGreyColor
        content.backgroundColor = UIColor.copYellowColor
    }
}
