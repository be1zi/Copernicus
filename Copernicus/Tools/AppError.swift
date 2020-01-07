//
//  AppError.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 07/01/2020.
//  Copyright © 2020 Konrad Bełzowski. All rights reserved.
//

import Foundation

enum AppError: Error {
    case geocoder
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .geocoder:
            return "error.geocoder.description".localized()
        }
    }
    
    var errorCode: Int? {
        switch self {
        case .geocoder:
            return 1
        }
    }
}
