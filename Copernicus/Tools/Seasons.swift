//
//  Seasons.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 15/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import Foundation

private struct SeasonDates {
    
    public static let springBegin = "21-03"
    public static let springEnd = "20-06"
    public static let summerBegin = "21-06"
    public static let summerEnd = "20-09"
    public static let autumnBegin = "21-09"
    public static let autumnEnd = "21-12"
    public static let winterBegin = "21-12"
    public static let winterEnd = "20-03"
}

private enum Season {
    case spring
    case summer
    case autumn
    case winter
}

public struct Seasons {
    
    //
    // MARK: - Properties
    //
    
    private static func getCurrentSeason() -> Season {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let year = calendar.component(.year, from: currentDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let springBeginDate = dateFormatter.date(from:"\(SeasonDates.springBegin)-\(String(describing: year))")
        let springEndDate = dateFormatter.date(from:"\(SeasonDates.springEnd)-\(String(describing: year))")
        
        if let sBeginDate = springBeginDate, let sEndDate = springEndDate {
            if currentDate.compare(sBeginDate) == .orderedDescending && currentDate.compare(sEndDate) == .orderedAscending {
                return .spring
            }
        }
        
        return .winter
    }
    
    public static func dateYearAgo() -> Date {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let year = calendar.component(.year, from: currentDate)
        
        
    }
}
