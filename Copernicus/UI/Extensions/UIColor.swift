//
//  UIColor.swift
//  Copernicus
//
//  Created by Konrad Belzowski on 17/12/2019.
//  Copyright © 2019 Konrad Bełzowski. All rights reserved.
//

import UIKit

extension UIColor {
    
    private static func colorWithHex(color: String, alpha: CGFloat = 1.0) -> UIColor {
        
        var colorString: String = color.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if colorString.hasPrefix("#") {
            colorString.remove(at: colorString.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: colorString).scanHexInt64(&rgbValue)
        
        return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat((rgbValue & 0x0000FF)) / 255.0,
                       alpha: alpha)
    }
    
    static var copGreyColor: UIColor {
        return UIColor.colorWithHex(color: "#627886")
    }
    
    static var copYellowColor: UIColor {
        return UIColor.colorWithHex(color: "FFDD00")
    }
    
    static var copBlueColor: UIColor {
        return UIColor.colorWithHex(color: "#1DB1D9")
    }
    
    static var copBlackColor: UIColor {
        return UIColor.colorWithHex(color: "2D2D2D")
    }
}
