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
        
        changeLocationButton.backgroundColor = UIColor.copYellowColor
        changeLocationButton.tintColor = UIColor.black
        changeLocationButton.cornerRadius = changeLocationButton.bounds.height / 2.0
        
        segmentedPager.segmentedControl.rx.controlEvent(.valueChanged).subscribe(onNext: { [weak self] _ in
            self?.updateSegmentedControllerBackground()
        }).disposed(by: disposeBag)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateSegmentedControllerBackground()
        
        segmentedPager.segmentedControl.clipsToBounds = true
        segmentedPager.segmentedControl.selectedTextColor = UIColor.black
        segmentedPager.segmentedControl.textColor = UIColor.copGreyColor
        segmentedPager.segmentedControlEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        segmentedPager.segmentedControl.borderColor = UIColor.copYellowColor
        segmentedPager.segmentedControl.borderWidth = 2.0
        segmentedPager.segmentedControl.cornerRadius = segmentedPager.segmentedControl.bounds.height / 2.0
    }
    
    private func updateSegmentedControllerBackground() {
        let selectedIndex = segmentedPager.segmentedControl.selectedIndex
        
        if selectedIndex == 0 {
            segmentedPager.segmentedControl.segment(at: selectedIndex)?.backgroundColor = UIColor.copYellowColor
            segmentedPager.segmentedControl.segment(at: 1)?.backgroundColor = UIColor.clear
        } else {
            segmentedPager.segmentedControl.segment(at: selectedIndex)?.backgroundColor = UIColor.copYellowColor
            segmentedPager.segmentedControl.segment(at: 0)?.backgroundColor = UIColor.clear
        }
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
