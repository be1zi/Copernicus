//
//  RecentImageryTableViewCellViewModel.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 20/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import Foundation

public struct RecentImageryTableViewCellViewModel {
    
    //
    // MARK: - Properties
    //
        
    public var date: String?
    public var satellite: String?
    
    //
    // MARK: - Init
    //
    
    public init(model: ImageryResultModel) {
        self.satellite = model.satellite
        self.date = prepareDate(model.endPositionDate)
    }
    
    //
    // MARK: - Helper
    //
    
    private func prepareDate(_ date: Date?) -> String? {
        
        guard let date = date else { return nil}
        
        return DateFormatter.dateToString(date: date)
    }
}
