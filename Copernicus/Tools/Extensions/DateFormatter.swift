//
//  DateFormatter.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 07/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import Foundation

private var DEFAULT_DISPLAY_DATE_FORMAT: String {get {return "dd/MM/yyyy"}}
private var DATE_TIME_FORMAT: String {get {return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"}}

extension DateFormatter {
    
    static func stringToDate(date: String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DATE_TIME_FORMAT
        
        return dateFormatter.date(from: date)
    }
    
    static func dateToString(date: Date?) -> String? {
        guard let date = date else { return nil}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DEFAULT_DISPLAY_DATE_FORMAT
        
        return dateFormatter.string(from: date)
    }
}
