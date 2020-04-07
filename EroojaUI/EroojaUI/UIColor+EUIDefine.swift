//
//  UIColor+EUIDefine.swift
//  EroojaUI
//
//  Created by 김태인 on 2020/04/07.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    enum ColorAlpha: CGFloat {
        case normal = 1.0
        case highlighted = 0.45
        case disabled = 0.5
    }

    convenience init(rgb: (r: UInt32, g: UInt32, b: UInt32 ), alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(rgb.r) / 255.0,
            green: CGFloat(rgb.g) / 255.0,
            blue: CGFloat(rgb.b) / 255.0,
            alpha: alpha
        )
    }
    
    convenience init(r: UInt32, g: UInt32, b: UInt32, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat(r) / 255.0,
            green: CGFloat(g) / 255.0,
            blue: CGFloat(b) / 255.0,
            alpha: alpha
        )
    }

    convenience init(rgb: UInt32, alpha: Float) {
        self.init(
            red: CGFloat(((rgb >> 16) & 0xFF)) / 255.0,
            green: CGFloat(((rgb >> 8) & 0xFF)) / 255.0,
            blue: CGFloat((rgb & 0xFF)) / 255.0,
            alpha: CGFloat(alpha)
        )
    }

    convenience init(rgba: UInt32) {
        self.init(
            red: CGFloat(((rgba >> 24) & 0xFF)) / 255.0,
            green: CGFloat(((rgba >> 16) & 0xFF)) / 255.0,
            blue: CGFloat(((rgba >> 8) & 0xFF)) / 255.0,
            alpha: CGFloat((rgba & 0xFF)) / 255.0
        )
    }

    convenience init?(rgba: String?, alpha: CGFloat = 1.0) {
        guard let rgba = rgba, rgba.hasPrefix("#") else {
            return nil
        }

        let startIndex = rgba.index(rgba.startIndex, offsetBy: 1)
        let hexString = String(rgba[startIndex...])
        var hexValue: UInt32 = 0

        guard Scanner(string: hexString).scanHexInt32(&hexValue) else {
            return nil
        }

        switch hexString.count {
        case 3:
            let divisor = CGFloat(15)
            let red = CGFloat((hexValue & 0xF00) >> 8) / divisor
            let green = CGFloat((hexValue & 0x0F0) >> 4) / divisor
            let blue = CGFloat( hexValue & 0x00F      ) / divisor
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        case 6:
            let divisor = CGFloat(255)
            let red = CGFloat((hexValue & 0xFF0000) >> 16) / divisor
            let green = CGFloat((hexValue & 0x00FF00) >> 8) / divisor
            let blue = CGFloat( hexValue & 0x0000FF       ) / divisor
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        case 8:
            let divisor = CGFloat(255)
            let red = CGFloat((hexValue & 0xFF000000) >> 24) / divisor
            let green = CGFloat((hexValue & 0x00FF0000) >> 16) / divisor
            let blue = CGFloat((hexValue & 0x0000FF00) >> 8) / divisor
            let alpha = CGFloat( hexValue & 0x000000FF       ) / divisor
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        default:
            return nil
        }
    }

    var hexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &alpha)

        let formattedRed = String(format: "%02x", Int(r * 255))
        let formattedGreen = String(format: "%02x", Int(g * 255))
        let formattedBlue = String(format: "%02x", Int(b * 255))
        let formattedAlpha = String(format: "%02x", Int(alpha * 255))

        let string = "#\(formattedRed)\(formattedGreen)\(formattedBlue)"
        if alpha < 1.0 {
            return "\(string)\(formattedAlpha)".uppercased()
        }
        return string.uppercased()
    }
}
