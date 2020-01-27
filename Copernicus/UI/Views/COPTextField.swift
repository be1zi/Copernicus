//
//  COPTextField.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 03/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import SkyFloatingLabelTextField

public class COPTextField: SkyFloatingLabelTextField {
    
    //
    // MAKR:- Properties
    //
    
    public override var title: String? {
        get {
            return self.placeholder
        }
        set {}
    }
    
    //
    // MARK: - Lifecycle
    //
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        setStyle()
    }
    
    //
    // MARK: - Style
    //
    
    private func setStyle() {
        lineColor = UIColor.copGreyColor
        titleColor = UIColor.copGreyColor
        
        selectedLineColor = UIColor.copBlueColor
        tintColor = UIColor.copBlueColor
        selectedTitleColor = UIColor.copBlueColor
    }
}
