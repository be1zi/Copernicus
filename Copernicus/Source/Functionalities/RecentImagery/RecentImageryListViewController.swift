//
//  RecentImageryListViewController.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 20/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import UIKit
import RxSwift

public class RecentImageryListViewController: BaseViewController {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var tableView: UITableView!

    private let viewModel = RecentImageryListViewModel()
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
        tableView.backgroundColor = UIColor.copBlackColor
        tableView.tableFooterView = UIView()
        
        tableView.register(UINib(nibName: viewModel.cellIdentifier, bundle: nil), forCellReuseIdentifier: viewModel.cellIdentifier)
    }
    
    //
    // MARK: - Action
    //
    
    public func setupRx() {
        
        viewModel.shouldReload.subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension RecentImageryListViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowNumber
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath) as? RecentImageryTableViewCell else {
            return UITableViewCell()
        }
        
        let model = RecentImageryTableViewCellViewModel(model: viewModel.imageryData[indexPath.row])
        cell.setViewModel(model)
        
        return cell
    }
}

extension RecentImageryListViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? RecentImageryTableViewCell else { return }
        
        guard let vc = UIStoryboard.init(name: viewModel.detailsIdentifier, bundle: nil).instantiateInitialViewController() as? RecentImageryDetailsViewController else {
            return
        }
        
        let vm = RecentImageryDetailsViewModel(imageryId: cell.getImageId())
        vc.setViewModel(vm)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
