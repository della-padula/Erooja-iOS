//
//  UIImage+Initialize.swift
//  erooja
//
//  Created by 김태인 on 2020/03/26.
//  Copyright © 2020 김태인. All rights reserved.
//

import UIKit

// MARK: - init with UIColor
extension UIImage {
    
    internal convenience init?(color: UIColor, size: CGSize = CGSize(width: 2, height: 2)) {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        color.setFill()
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        
        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
}
