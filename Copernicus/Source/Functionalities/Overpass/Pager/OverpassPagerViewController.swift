//
//  OverpassPagerViewController.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 05/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import UIKit
import MXSegmentedPager
import RxSwift

public class OverpassPagerViewController: BaseViewController {

    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var segmentedPager: MXSegmentedPager!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var changeLocationButton: UIButton!
    @IBOutlet weak var separatorView: UIView!
    
    private let viewModel = OverpassPagerViewModel()
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
        separatorView.backgroundColor = UIColor.copYellowColor
    }
    
    //
    // MARK: - Data
    //
    
    private func setStaticData() {
        subtitleLabel.text = viewModel.subtitle
        changeLocationButton.setTitle(viewModel.changeButton, for: .normal)
    }
    
    public func setDynamicData() {
        currentLocationLabel.text = viewModel.locationString
    }
    
    private func setupRx() {
        viewModel.location.subscribe(onNext: { [weak self] _ in
            self?.setDynamicData()
        }).disposed(by: disposeBag)
    }
}

extension OverpassPagerViewController: MXSegmentedPagerControllerDataSource {
    
    public func numberOfPages(in segmentedPager: MXSegmentedPager) -> Int {
        return viewModel.controllersNumber
    }
    
    public func segmentedPager(_ segmentedPager: MXSegmentedPager, viewControllerForPageAt index: Int) -> UIViewController {
        return viewModel.viewController(atIndex: index)
    }
    
    public func segmentedPager(_ segmentedPager: MXSegmentedPager, segueIdentifierForPageAt index: Int) -> String {
        return viewModel.segue
    }
    
    public func segmentedPager(_ segmentedPager: MXSegmentedPager, viewForPageAt index: Int) -> UIView {
        return viewModel.viewForController(atIndex: index)
    }
    
    public func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt index: Int) -> String {
        return viewModel.titleForController(atIndex: index)
    }
}

