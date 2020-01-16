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
    
    private static func getCurrentSeason(_ currentDate: Date) -> Season {
        
        if Seasons.isInSeason(begin: SeasonDates.springBegin, end: SeasonDates.springEnd, date: currentDate) {
            return .spring
        }
        
        if Seasons.isInSeason(begin: SeasonDates.summerBegin, end: SeasonDates.summerEnd, date: currentDate) {
            return .summer
        }
        
        if Seasons.isInSeason(begin: SeasonDates.autumnBegin, end: SeasonDates.autumnEnd, date: currentDate) {
            return .autumn
        }
        
        return .winter
    }
    
    private static func isInSeason(begin: String, end: String, date: Date) -> Bool {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let beginDate = dateFormatter.date(from:"\(begin)-\(String(describing: year))")
        let endDate = dateFormatter.date(from:"\(end)-\(String(describing: year))")
        
        if let firstDayOfSeason = beginDate, let lastDayOfSeason = endDate {
            if date.compare(firstDayOfSeason) == .orderedDescending && date.compare(lastDayOfSeason) == .orderedAscending {
                return true
            }
        }
        
        return false
    }
    
    public static func dateYearAgo() -> Date {
        let calendar = Calendar.current
        let currentDate = Date()
        var year = calendar.component(.year, from: currentDate) - 1
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        let season = getCurrentSeason(currentDate)
        var dateString = ""
        
        switch season {
        case .spring:
            dateString = SeasonDates.springBegin
        case .summer:
            dateString = SeasonDates.autumnBegin
        case .autumn:
            dateString = SeasonDates.winterBegin
        case .winter:
            dateString = SeasonDates.springBegin
            
            let month = calendar.component(.month, from: currentDate)
    
            // if december then get first day of spring in the same year
            if month == 12 {
                year += 1
            }
        }
        
        return dateFormatter.date(from:"\(dateString)-\(String(describing: year))") ?? currentDate
        
    }
}
