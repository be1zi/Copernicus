//
//  OverpassListViewController.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 04/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import UIKit
import RxSwift

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
    private let disposeBag = DisposeBag()
    
    //
    // MARK: - Lifecycle
    //
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupRx()
        
        setStaticData()
        setDynamicData()
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
        //tableView.tableFooterView = UIView()
        //separatorView.backgroundColor = UIColor.copYellowColor
    }
    
    //
    // MARK: - Data
    //
    
    private func setStaticData() {
        //subtitleLabel.text = viewModel.subtitle
       // changeLocationButton.setTitle(viewModel.changeButton, for: .normal)
    }
    
    public func setDynamicData() {
        //currentLocationLabel.text = viewModel.locationString
    }
    
    private func setupRx() {
        viewModel.location.subscribe(onNext: { [weak self] _ in
            self?.setDynamicData()
        }).disposed(by: disposeBag)
    }
}
