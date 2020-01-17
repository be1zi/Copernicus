//
//  CloudyTableViewCellViewModel.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 15/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import Foundation

public struct CloudyTableViewCellViewModel {
    
    //
    // MARK: - Properties
    //
    
    public var satellite: String?
    public var date: String?
    public var cloudy: String?
    
    //
    // MARK: - Init
    //
    
    public init(imagery: ImageryResultModel) {
        self.satellite = imagery.satellite
        self.cloudy = "\(String(describing: imagery.cloudCoverPercentage))%"
        self.date = prepareDate(imagery.endPositionDate)
    }
    
    private func prepareDate(_ date: Date?) -> String? {
        
        guard let date = date else { return nil}
        
        return DateFormatter.dateToString(date: date)
    }
}
