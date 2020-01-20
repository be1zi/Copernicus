//
//  RecentImageryDetailsViewController.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 20/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

public class RecentImageryDetailsViewController: BaseViewController {
    
    //
    // MARK: - Properties
    //
    
    public var viewModel: RecentImageryDetailsViewModel?
    
    //
    // MARK: - Data
    //
    
    public func setViewModel(_ vm: RecentImageryDetailsViewModel) {
        viewModel = vm
    }
}
