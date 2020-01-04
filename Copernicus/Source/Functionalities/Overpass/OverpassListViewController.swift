//
//  OverpassListViewController.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 04/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import UIKit

public class OverpassListViewController: BaseViewController {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var changeLocationButton: UIButton!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = OverpassListViewModel()
    
    //
    // MARK: - Lifecycle
    //
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    //
    // MARK: - Appearance
    //
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    public override func navigationBarTitle() -> String? {
        return viewModel.title
    }
    
    private func setupView() {
        tableView.tableFooterView = UIView()
        separatorView.backgroundColor = UIColor.copYellowColor
    }
    
    //
    // MARK: - Data
    //
    
    private func setData() {
        subtitleLabel.text = viewModel.subtitle
        
        changeLocationButton.setTitle(viewModel.changeButton, for: .normal)
    }
}
