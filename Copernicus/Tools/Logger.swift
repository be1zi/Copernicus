//
//  Logger.swift
//  Copernicus
//
//  Created by Konrad Bełzowski on 15/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import Foundation
import os.log

struct Logger {
    
    private static var log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "DEFAULT")
    
    static func setType(_ type: Any) {
        log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: String(describing: type))
    }
    
    static func logError(error: Error) {
        os_log("%@", log: log, type: .error, error.localizedDescription)
    }
    
    static func logError(description: String) {
        os_log("%@", log: log, type: .error, description)
    }
    
    static func logInfo(info: String) {
        os_log("%@", log: log, type: .info, info)
    }
}
