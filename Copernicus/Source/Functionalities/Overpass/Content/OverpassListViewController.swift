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
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: OverpassListViewModel!
    private let disposeBag = DisposeBag()
    
    //
    // MARK: - Lifecycle
    //
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupRx()
        registerCells()
    }
    
    //
    // MARK: - Appearance
    //
    
    private func setupView() {
        tableView.tableFooterView = UIView()
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 50.0
    }
    
    //
    // MARK: - Data
    //
    
    public func setViewModel(_ vm: OverpassListViewModel) {
        self.viewModel = vm
    }
    
    private func setupRx() {
        
        viewModel.changed.subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    private func registerCells() {
        viewModel.cellIdentifiers.forEach { cellIdentifier in
            tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        }
        
        tableView.register(UINib(nibName: viewModel.headerIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: viewModel.headerIdentifier)
    }
}

extension OverpassListViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellNumber
    }
        
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellType.rawValue, for: indexPath)
        let overpass = viewModel.overpasses[indexPath.row]

        switch viewModel.cellType {
        case .Future:
            guard let newCell = cell as? OverpassListFutureTableViewCell else { return UITableViewCell() }
            
            let viewModel = OverpassListFutureViewModel(overpass)
            newCell.setViewModel(viewModel)
            
            return newCell
        
        case .Past:
            guard let newCell = cell as? OverpassListPastTableViewCell else { return UITableViewCell() }
            
            let viewModel = OverpassListPastViewModel(overpass)
            newCell.setViewModel(viewModel)
            
            return newCell
        }
    }
}

extension OverpassListViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: viewModel.headerIdentifier) as? OverpassListHeaderTableViewCell
        
        if let headerCell = headerView {
            let headerViewModel = OverpassListHeaderViewModel(frequency: viewModel.frequency)
            headerCell.setViewModel(headerViewModel)
            
            return headerCell
        }
        
        return UITableViewHeaderFooterView()
    }
}
