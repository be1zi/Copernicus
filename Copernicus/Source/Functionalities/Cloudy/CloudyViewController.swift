//
//  CloudyViewController.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 14/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import UIKit
import RxSwift

public class CloudyViewController: BaseViewController {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    private let viewModel = CloudyViewModel()
    private let disposeBag = DisposeBag()
    
    //
    // MARK: - Lifecycle
    //
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupRx()
        setStaticData()
        registerCells()
    }
    
    //
    // MARK: - Appearance
    //
    
    public override func shouldHideNavigationBar() -> Bool {
        return true
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    private func setupView() {
        tableView.tableFooterView = UIView()
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 50.0
        
        contentView.backgroundColor = UIColor.copBlackColor
    }
    
    //
    // MARK: - Data
    //
    
    private func setStaticData() {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: viewModel.headerIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: viewModel.headerIdentifier)
    }
    
    //
    // MARK: - Action
    //
    
    private func setupRx() {
        backButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        viewModel.shouldReload.subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension CloudyViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.seasonsCount
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.imageryCount
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension CloudyViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: viewModel.headerIdentifier)
        
        return header
    }
}
