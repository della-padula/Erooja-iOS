//
//  UIImage+Resize.swift
//  erooja
//
//  Created by 김태인 on 2020/03/26.
//  Copyright © 2020 김태인. All rights reserved.
//

import UIKit

public extension UIImage {
    @objc func croppedImage(_ bounds: CGRect) -> UIImage {
        guard let imageRef: CGImage = cgImage?.cropping(to: CGRect(x: bounds.origin.x * scale, y: bounds.origin.y * scale, width: bounds.size.width * scale, height: bounds.size.height * scale)) else {
            return self
        }
        let croppedImage = UIImage(cgImage: imageRef, scale: scale, orientation: imageOrientation)
        return croppedImage
    }
}
