//
//  WalkthroughPageViewController.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 18/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class WalkthroughPageViewController: UIPageViewController {
    
    //
    // MARK: - Properties
    //
    
    private let viewModel = WalkthroughViewModel()
    private let disposeBag = DisposeBag()
    
    //
    // MARK: - Lifecycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPager()
        setupRx()
    }
    
    //
    // MARK: - Methods
    //
    
    private func setupPager() {
        self.dataSource = self
        
        if let firstPage = viewModel.firstPage {
            setViewControllers([firstPage], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private func setupRx() {
//        Observable.merge(viewModel.pages.map { [weak self] vc in
//            vc.loopBehaviorRelay.asObservable
//        })
        
        Observable.merge(viewModel.pages[0].loopBehaviorRelay.asObservable(),
                         viewModel.pages[1].loopBehaviorRelay.asObservable(),
                         viewModel.pages[2].loopBehaviorRelay.asObservable())
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] loopValue in
                self?.viewModel.pages[0].loopBehaviorRelay.accept(loopValue)
                self?.viewModel.pages[1].loopBehaviorRelay.accept(loopValue)
                self?.viewModel.pages[2].loopBehaviorRelay.accept(loopValue)
            }).disposed(by: disposeBag)
        
        Observable.merge(viewModel.pages[0].skipBehaviorRelay.asObservable(),
                         viewModel.pages[1].skipBehaviorRelay.asObservable(),
                         viewModel.pages[2].skipBehaviorRelay.asObservable())
            .subscribe(onNext: { _ in
                DispatchQueue.main.async {
                    AppDelegate.sharedInstance.windowController?.presentHomeController()
                }
            }).disposed(by: disposeBag)
    }
}

extension WalkthroughPageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let vc = viewController as? WalkthroughContentViewController else { return nil }
        
        guard let index = viewModel.pages.firstIndex(of: vc), index > 0 else {
            return nil
        }

        return viewModel.pages[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vc = viewController as? WalkthroughContentViewController else { return nil }

        guard let index = viewModel.pages.firstIndex(of: vc), index < viewModel.pages.count - 1 else {
            return nil
        }

        return viewModel.pages[index + 1]
    }
}
