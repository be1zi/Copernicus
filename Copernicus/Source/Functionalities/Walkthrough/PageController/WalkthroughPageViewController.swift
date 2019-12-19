//
//  WalkthroughPageViewController.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 18/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import UIKit

class WalkthroughPageViewController: UIPageViewController {
    
    //
    // MARK: - Properties
    //
    
    private let viewModel = WalkthroughViewModel()
    
    //
    // MARK: - Lifecycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPager()
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
