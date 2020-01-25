//
//  RecentImageryDetailsViewController.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 20/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import UIKit
import RxSwift

public class RecentImageryDetailsViewController: BaseViewController {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var tableView: UITableView!
    
    public var viewModel: RecentImageryDetailsViewModel?
    private let disposeBag = DisposeBag()
    
    //
    // MARK: - Lifecycle
    //
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupRx()
    }
    
    //
    // MARK: - Appearance
    //
    
    private func setupView() {
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.copBlackColor
        
        guard let vm = viewModel else { return }
        
        tableView.register(UINib(nibName: vm.cellIdentifier, bundle: nil), forCellReuseIdentifier: vm.cellIdentifier)
    }
    
    //
    // MARK: - Data
    //
    
    public func setViewModel(_ vm: RecentImageryDetailsViewModel) {
        viewModel = vm
    }
    
    //
    // MARK: - Action
    //
    
    private func setupRx() {
        guard let vm = viewModel else { return }
        
        vm.shouldReload.subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension RecentImageryDetailsViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.rowNumber ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let vm = viewModel,
            let cell = tableView.dequeueReusableCell(withIdentifier: vm.cellIdentifier, for: indexPath) as? RecentImageryDetailsTableViewCell else {
                return UITableViewCell()
        }
        
        let model = RecentImageryDetailsTableViewCellModel(model: vm.imageModels[indexPath.row], basePath: vm.basePath)
        cell.setViewModel(model)
        
        return cell
    }
}
