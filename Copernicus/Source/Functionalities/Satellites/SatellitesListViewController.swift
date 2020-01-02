//
//  SatellitesListViewController.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 30/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import UIKit
import RxSwift

public class SatellitesListViewController: BaseViewController {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var tableView: UITableView!

    private let viewModel = SatellitesListViewModel()
    private let disposeBag = DisposeBag()
    
    //
    // MARK: - Lifecycle
    //
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        setupRx()
        
        tableView.tableFooterView = UIView()
    }
    
    //
    // MARK: - Appearance
    //
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    public override func navigationBarTitle() -> String? {
        return "satellites.list.title".localized()
    }
    
    //
    // MARK: - Methods
    //
    
    private func registerCell() {
        
        tableView.register(UINib(nibName: viewModel.cellName, bundle: nil), forCellReuseIdentifier: viewModel.cellName)
    }
    
    private func setupRx() {
        
        viewModel.satellites.subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension SatellitesListViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.satellitesCount
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let newCell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellName, for: indexPath) as? SatellitesListCell
        let satellite = viewModel.satellites.value[indexPath.row]
        
        guard let cell = newCell else { return UITableViewCell() }
        
        cell.setupViewModel(SatellitesListCellViewModel(satellite:satellite))
        
        return cell
    }
}
