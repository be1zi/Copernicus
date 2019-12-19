//
//  WalkthroughViewModel.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 19/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import UIKit

public struct WalkthroughViewModel {
    
    //
    // MARK: - Properties
    //
    
    private var data: [WalkthroughData] = []
    public var pages: [WalkthroughContentViewController] = []
    public var firstPage: WalkthroughContentViewController?
    
    //
    // MARK: - Init
    //
    
    public init() {
        createData()
        createViewControllers()
    }
    
    //
    // MARK: - Methods
    //
    
    private mutating func createData() {
        data = [WalkthroughData(background: UIImage(named: "walkthroughBackground1"), number: 1),
                WalkthroughData(background: UIImage(named: "walkthroughBackground2"), number: 2),
                WalkthroughData(background: UIImage(named: "walkthroughBackground3"), number: 3)]
    }
    
    private mutating func createViewControllers() {
        
        let storyboard = UIStoryboard(name: "Walkthrough", bundle: nil)
            
        let vc1 = storyboard.instantiateViewController(withIdentifier: String(describing: WalkthroughContentViewController.self)) as? WalkthroughContentViewController
        let vc2 = storyboard.instantiateViewController(withIdentifier: String(describing: WalkthroughContentViewController.self)) as? WalkthroughContentViewController
        let vc3 = storyboard.instantiateViewController(withIdentifier: String(describing: WalkthroughContentViewController.self)) as? WalkthroughContentViewController
        
        vc1?.setData(data[0])
        vc2?.setData(data[1])
        vc3?.setData(data[2])
        
        if let VC1 = vc1 { pages.append(VC1) }
        if let VC2 = vc2 { pages.append(VC2) }
        if let VC3 = vc3 { pages.append(VC3) }
        
        firstPage = pages.first
    }
}
