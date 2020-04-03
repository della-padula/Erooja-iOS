//
//  UIColor+ContrastingColor.swift
//  erooja
//
//  Created by denny.k on 2020/03/26.
//  Copyright © 2020 denny.k. All rights reserved.
//

import UIKit
import EroojaCommon

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}

public extension UIColor {
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        
        var hex = hex.deletingPrefix("#")
        hex = hex.deletingPrefix("0x")
        if hex.count != 6 {
            ELog.error(message: "")
        }
        
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let red = (rgbValue & 0xff0000) >> 16
        let green = (rgbValue & 0xff00) >> 8
        let blue = rgbValue & 0xff
        
        self.init(red: CGFloat(red) / 0xff, green: CGFloat(green) / 0xff, blue: CGFloat(blue) / 0xff, alpha: alpha)
    }
    
    convenience init(rgb: UInt32) {
        self.init(
            red: CGFloat(((rgb >> 16) & 0xFF)) / 255.0,
            green: CGFloat(((rgb >> 8) & 0xFF)) / 255.0,
            blue: CGFloat((rgb & 0xFF)) / 255.0,
            alpha: 1.0
        )
    }
    
    @objc func blackOrWhiteContrastingColor() -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        let a = Double(1 - ((0.299 * red) + (0.587 * green) + (0.114 * blue)))
        if a < 0.45 {
            //return black
            return .black
        } else {
            //return white
            return .white
        }
    }
    
    func blackOrWhiteContrastingColor35() -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        let a = Double(1 - ((0.299 * red) + (0.587 * green) + (0.114 * blue)))
        if a < 0.35 {
            //return black
            return .black
        } else {
            //return white
            return .white
        }
    }
    
    @objc func grayOrWhiteContrastingColor() -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        let a = Double(1 - ((0.299 * red) + (0.587 * green) + (0.114 * blue)))
        if a < 0.45 {
            //return black
            return UIColor.gray
        } else {
            //return white
            return UIColor.white
        }
    }
    
    func whiteOrGrayOrDarkGrayContrastingColor() -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        let a = Double(1 - ((0.299 * red) + (0.587 * green) + (0.114 * blue)))
        if a < 0.35 {
            //return light
            return UIColor(rgb: 0x555555)
        } else if a < 0.55 {
            //return medium
            return UIColor.white
        } else {
            //return dark
            return UIColor.gray
        }
    }
    
    @objc func isDark() -> Bool {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        let a = Double(1 - ((0.299 * red) + (0.587 * green) + (0.114 * blue)))
        if a < 0.45 {
            return false
        }
        return true
    }
    
    func isLight() -> Bool {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: nil)
        let a = Double(1 - ((0.299 * red) + (0.587 * green) + (0.114 * blue)))
        if a < 0.35 {
            return true
        }
        return false
    }
}

