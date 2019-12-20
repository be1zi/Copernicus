//
//  WalkthroughContentViewController.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 18/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public class WalkthroughContentViewController: BaseViewController {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var loopImageView: UIImageView!
    @IBOutlet weak var loopLabel: UILabel!
    @IBOutlet weak var loopContainerView: UIView!
    @IBOutlet weak var skipButton: UIButton!
    
    private let loopTapGesture = UITapGestureRecognizer()
    private let disposeBag = DisposeBag()
    
    private var viewModel: WalkthroughContentViewModel?
    public var loopBehaviorRelay = BehaviorRelay<Bool>(value: true)
    public var skipBehaviorRelay = ReplaySubject<Void>.create(bufferSize: 1)
    
    //
    // MARK: - Appearance
    //

    override public func shouldHideBackButton() -> Bool {
        return true
    }
    
    override public func shouldHideNavigationBar() -> Bool {
        return true
    }
    
    //
    // MARK: - Lifecycle
    //
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setStyle()
        setData()
        setupView()
        setLoopImage()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setLoopImage()
    }
    
    //
    // MARK: - Data
    //
    
    public func setViewModel(_ viewModel: WalkthroughContentViewModel) {
        self.viewModel = viewModel
    }
    
    //
    // MARK: - Methods
    //
    
    private func setupView() {
        loopContainerView.addGestureRecognizer(loopTapGesture)
        
        loopTapGesture.rx.event.subscribe(onNext: { [weak self] _ in
            let previousValue = self?.loopBehaviorRelay.value ?? true
            self?.loopBehaviorRelay.accept(!previousValue)
            self?.setLoopImage()
        }).disposed(by: disposeBag)
        
        skipButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.skipBehaviorRelay.on(.next(()))
        }).disposed(by: disposeBag)
    }
    
    private func setData() {
        backgroundImageView.image = viewModel?.backgroundImage
        numberLabel.text = viewModel?.numberString
        appNameLabel.text = viewModel?.appName
        infoLabel.text = viewModel?.description
        loopLabel.text = viewModel?.loopTitle
    }
    
    private func setStyle() {
        infoLabel.textColor = UIColor.copGreyColor
        loopLabel.textColor = UIColor.copBlueColor
    }
    
    private func setLoopImage() {
        let enabled = loopBehaviorRelay.value
        
        if enabled {
            loopImageView.image = viewModel?.loopImageEnabled
        } else {
            loopImageView.image = viewModel?.loopImageDisabled
        }
    }
}
