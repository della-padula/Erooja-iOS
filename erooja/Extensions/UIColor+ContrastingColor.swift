//
//  UIColor+ContrastingColor.swift
//  erooja
//
//  Created by denny.k on 2020/03/26.
//  Copyright © 2020 denny.k. All rights reserved.
//

import UIKit
import Foundation

public extension UIColor {
    
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

