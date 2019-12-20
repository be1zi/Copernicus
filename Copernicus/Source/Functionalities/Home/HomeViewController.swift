//
//  HomeViewController.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 17/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var logoContainerView: UIView!
    @IBOutlet weak var logoOvalView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var headerBackgroundImageView: UIImageView!
    
    private let viewModel = HomeViewModel()
    
    //
    // MARK: - Appearance
    //
    
    override func shouldHideNavigationBar() -> Bool {
        return true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    //
    // MARK: - Lifecycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        setupView()
    }
    
    //
    // MARK: - Methods
    //
    
    private func registerCell() {
        let cellName = String(describing: HomeCellView.self)
        collectionView.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
    }
    
    private func setupView() {
        nameLabel.text = viewModel.appName
        headerBackgroundImageView.image = viewModel.headerBackground
        logoOvalView.image = viewModel.ovalImage
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellsNumber
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let newCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HomeCellView.self), for: indexPath) as? HomeCellView
        
        guard let cell = newCell else {
            return UICollectionViewCell()
        }
        
        cell.setViewModel(viewModel.cellViewModels[indexPath.row])
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        guard let cell = collectionView.cellForItem(at: indexPath) as? HomeCellView,
            let storyboardName = cell.viewModel?.storyboardName else {
            return
        }
        
        let vc = UIStoryboard.init(name: storyboardName, bundle: nil).instantiateInitialViewController()
        
        guard let viewController = vc else {
            return
        }
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (UIScreen.main.bounds.width - 60.0) / 2.0
        
        return CGSize(width: size, height: 1.4 * size)
    }
}
