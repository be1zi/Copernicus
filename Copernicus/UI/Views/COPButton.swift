//
//  COPButton.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 17/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import UIKit

class COPButton: UIButton {
    
    //
    // MARK: - Lifecycle
    //
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setStyle()
    }
    
    //
    // MARK: - Style
    //
    
    private func setStyle() {
        self.cornerRadius = self.frame.height / 2.0
        self.backgroundColor = UIColor.red
        self.tintColor = UIColor.white
        self.titleLabel?.font = UIFont.buttonFont
    }
}
