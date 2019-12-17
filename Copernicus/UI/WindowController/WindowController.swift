//
//  WindowController.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 17/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import UIKit

struct WindowController {
    
    var window: UIWindow
    
    //
    // MARK: - Init
    //
    
    public init(window: UIWindow) {
        self.window = window
    }
    
    //
    // MARK: - Methods
    //
    
    public func presentLanguageController() {
        
        let vc = UIStoryboard.init(name: "Language", bundle: nil).instantiateInitialViewController()
        
        guard let viewController = vc else {
            return
        }
        
        presentViewControllerAsRoot(viewController)
    }
    
    public func presentHomeController() {
        let vc = UIStoryboard.init(name: "Home", bundle: nil).instantiateInitialViewController()
        
        guard let viewController = vc else {
            return
        }
        
        presentViewControllerAsRoot(viewController)
    }
    
    //
    // MARK: - Helper
    //
    
    private func presentViewControllerAsRoot(_ viewController: UIViewController) {
        
        let rootViewController = window.rootViewController
        
        window.rootViewController = viewController
        
        if let previousRootVC = rootViewController {
            previousRootVC.dismiss(animated: false) {
                previousRootVC.view.removeFromSuperview()
            }
        }
    }
}
