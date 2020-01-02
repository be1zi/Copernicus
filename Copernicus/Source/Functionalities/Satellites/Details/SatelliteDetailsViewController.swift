//
//  SatelliteDetailsViewController.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 02/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import UIKit
import RxSwift

public class SatelliteDetailsViewController: BaseViewController {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var titleLabel: UILabel!
    
    private var viewModel: SatelliteDetailsViewModel?
    private let disposeBag = DisposeBag()
    
    //
    // MARK: - Lifecycle
    //
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        setupRx()
    }
    
    //
    // MARK: - Appearance
    //
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    //
    // MARK: - Methods
    //
    
    public func setViewModel(viewModel: SatelliteDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    public func setData() {
        titleLabel.text = viewModel?.title
    }
    
    private func setupRx() {
        
        viewModel?.changed.subscribe(onNext: {
            // reload map
        }).disposed(by: disposeBag)
    }
}
