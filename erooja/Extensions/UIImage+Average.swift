//
//  UIImage+Average.swift
//  erooja
//
//  Created by 김태인 on 2020/03/26.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    
    @objc
    func averageColor() -> UIColor {
        guard let cgImage = cgImage else {
            return .clear
        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var rgba = [UInt8](repeating: 0, count: 4)
        let context = CGContext(data: &rgba,
                                width: 1,
                                height: 1,
                                bitsPerComponent: 8,
                                bytesPerRow: 4,
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue)
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: 1, height: 1))

        return UIColor(red: (CGFloat(rgba[0])) / 255.0, green: (CGFloat(rgba[1])) / 255.0, blue: (CGFloat(rgba[2])) / 255.0, alpha: (CGFloat(rgba[3])) / 255.0)
    }
    
    @objc
    func averageColor(alpha: CGFloat) -> UIColor {
        guard let cgImage = cgImage else {
            return .clear
        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var rgba = [UInt8](repeating: 0, count: 4)
        if let context = CGContext(data: &rgba,
                                   width: 1,
                                   height: 1,
                                   bitsPerComponent: 8,
                                   bytesPerRow: 4,
                                   space: colorSpace,
                                   bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue) {
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: 1, height: 1))
            
            if alpha > 0 {
                let multiplier: CGFloat = alpha / 255
                return UIColor(red: (CGFloat(rgba[0])) * multiplier,
                               green: (CGFloat(rgba[1])) * multiplier,
                               blue: (CGFloat(rgba[2])) * multiplier,
                               alpha: alpha)
            } else {
                return UIColor(red: (CGFloat(rgba[0])) / 255.0,
                               green: (CGFloat(rgba[1])) / 255.0,
                               blue: (CGFloat(rgba[2])) / 255.0,
                               alpha: (CGFloat(rgba[3])) / 255.0)
            }
            
        }
        return .clear
    }
    
    @objc
    func averageCenterColor() -> UIColor {
        guard let cgImage = cgImage else {
            return .clear
        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var rgba = [UInt8](repeating: 0, count: 4)
        if let context = CGContext(data: &rgba,
                                   width: 1,
                                   height: 1,
                                   bitsPerComponent: 8,
                                   bytesPerRow: 4,
                                   space: colorSpace,
                                   bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue) {
            context.draw(cgImage, in: CGRect(x: -(floor(size.width / 2)), y: -(floor(size.height / 2)), width: size.width, height: size.height))

            return UIColor(red: (CGFloat(rgba[0])) / 255.0, green: (CGFloat(rgba[1])) / 255.0, blue: (CGFloat(rgba[2])) / 255.0, alpha: (CGFloat(rgba[3])) / 255.0)
        }
        return .clear
    }
    
    @objc
    func averageCenterColor(alpha: CGFloat) -> UIColor {
        guard let cgImage = cgImage else {
            return .clear
        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        var rgba = [UInt8](repeating: 0, count: 4)
        if let context = CGContext(data: &rgba,
                                   width: 1,
                                   height: 1,
                                   bitsPerComponent: 8,
                                   bytesPerRow: 4,
                                   space: colorSpace,
                                   bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue) {
            context.draw(cgImage, in: CGRect(x: -(floor(size.width / 2)), y: -(floor(size.height / 2)), width: size.width, height: size.height))
            
            if alpha > 0 {
                let multiplier: CGFloat = alpha / 255
                return UIColor(red: (CGFloat(rgba[0])) * multiplier,
                               green: (CGFloat(rgba[1])) * multiplier,
                               blue: (CGFloat(rgba[2])) * multiplier,
                               alpha: alpha)
            } else {
                return UIColor(red: (CGFloat(rgba[0])) / 255.0,
                               green: (CGFloat(rgba[1])) / 255.0,
                               blue: (CGFloat(rgba[2])) / 255.0,
                               alpha: (CGFloat(rgba[3])) / 255.0)
            }
        }
        return .clear
    }
    
}
