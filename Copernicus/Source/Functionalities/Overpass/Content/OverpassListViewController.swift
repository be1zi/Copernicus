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
    
    private let viewModel = OverpassListViewModel()
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
    }
    
    //
    // MARK: - Data
    //
    
    private func setupRx() {
        
        viewModel.changed.subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: viewModel.cellIdentifier, bundle: nil), forCellReuseIdentifier: viewModel.cellIdentifier)
    }
}

extension OverpassListViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellNumber
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let newCell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath)
        
        guard let overpass = viewModel.overpass?.overpasses[indexPath.row] else {
            return UITableViewCell()
        }
        
        if let cell = newCell as? OverpassListFutureTableViewCell {
            let viewModel = OverpassListFutureViewModel(overpass)
            cell.setViewModel(viewModel)
            
            return cell
        }
        
        return UITableViewCell()
    }
}
