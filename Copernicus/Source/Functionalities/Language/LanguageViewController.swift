//
//  LanguageViewController.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 16/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import UIKit

class LanguageViewController: BaseViewController {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var polishButton: UIButton!
    @IBOutlet weak var englishButton: UIButton!
    
    private let viewModel = LanguageViewModel()
    
    //
    // MARK: - Lifecycle
    //
    
    override func viewDidLoad() {
        setData()
    }
    
    //
    // MARK: - Methods
    //
    
    private func setData() {
        infoLabel.text = viewModel.infoMessage
        polishButton.setTitle(viewModel.polishButtonTitle, for: .normal)
        englishButton.setTitle(viewModel.englishButtonTitle, for: .normal)
    }
}
