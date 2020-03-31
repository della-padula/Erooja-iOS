//
//  UIImage+Crop.swift
//  erooja
//
//  Created by denny.k on 2020/03/26.
//  Copyright © 2020 denny.k. All rights reserved.
//

import UIKit
import Foundation

public extension UIImage {
    
    func topCenterAlignedCroppedImage(_ size: CGSize) -> UIImage? {
        guard let cgImage = self.cgImage else {
            return nil
        }
        let cropSize = CGSize(width: size.width * scale, height: size.height * scale)
        let contextImage: UIImage = UIImage(cgImage: cgImage)
        let contextSize: CGSize = contextImage.size
        let cgWidth: CGFloat = min(cropSize.width, contextSize.width)
        let cgHeight: CGFloat = min(cropSize.height, contextSize.height)
        let posX: CGFloat = (contextSize.width - cgWidth) / 2
        let rect: CGRect = CGRect(x: posX, y: 0, width: cgWidth, height: cgHeight)
        if let imageRef = cgImage.cropping(to: rect) {
            return UIImage(cgImage: imageRef, scale: scale, orientation: imageOrientation)
        }
        return nil
    }
    
    @objc func scaleCroppedImage(cropSize: CGSize, baseSize: CGSize) -> UIImage? {
        var cropImage: UIImage? = nil
        UIGraphicsBeginImageContext(cropSize)
        let drawRect = CGRect(x: 0, y: 0, width: baseSize.width, height: baseSize.height)
        let scaleForFit: CGFloat = drawRect.width / size.width
        var scaledImageSize = CGSize(width: drawRect.width, height: size.height * scaleForFit)
        let yForBottomAlign: CGFloat = drawRect.height - scaledImageSize.height
        if yForBottomAlign <= 0 {
            draw(in: CGRect(x: 0, y: 0, width: scaledImageSize.width, height: scaledImageSize.height))
        } else {
            let scaleForFit: CGFloat = drawRect.height / size.height
            scaledImageSize = CGSize(width: size.width * scaleForFit, height: drawRect.height)
            draw(in: CGRect(x: (drawRect.width - scaledImageSize.width) / 2.0, y: 0, width: scaledImageSize.width, height: scaledImageSize.height))
        }
        cropImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return cropImage
    }

    @objc func bottomAlignedResizeCroppedImage(_ size: CGSize) -> UIImage? {
        guard let cgImage = self.cgImage else {
            return nil
        }
        let cropSize = CGSize(width: size.width * scale, height: size.height * scale)
        let contextImage: UIImage = UIImage(cgImage: cgImage)
        let contextSize: CGSize = contextImage.size
        var cgWidth: CGFloat = min(cropSize.width, contextSize.width)
        var cgHeight: CGFloat = min(cropSize.height, contextSize.height)
        if contextSize.height / contextSize.width < cropSize.height / cropSize.width {
            cgHeight = contextSize.height
            cgWidth = ceil(contextSize.height * cropSize.width / cropSize.height / scale) * scale
        } else {
            cgWidth = contextSize.width
            cgHeight = ceil(contextSize.width * cropSize.height / cropSize.width / scale) * scale
        }
        let posX: CGFloat = (contextSize.width - cgWidth) / 2
        let rect: CGRect = CGRect(x: posX, y: contextSize.height - cgHeight, width: cgWidth, height: cgHeight)
        if let imageRef = cgImage.cropping(to: rect) {
            return UIImage(cgImage: imageRef, scale: scale, orientation: imageOrientation)
        }
        return nil
    }
    
    @objc func marginedImage(leftOffset: CGFloat, rightOffset: CGFloat) -> UIImage? {
        var newsize: CGSize = size
        newsize.width += leftOffset + rightOffset
        UIGraphicsBeginImageContextWithOptions(newsize, false, scale)
        draw(in: CGRect(x: leftOffset, y: 0, width: newsize.width - leftOffset - rightOffset, height: newsize.height))
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    @objc func centerCropToSquareImage() -> UIImage? {
        let minSide = min(size.width, size.height)
        let squareRect = CGRect(x: (size.width - minSide) / 2, y: (size.height - minSide) / 2, width: minSide, height: minSide)
        return croppedImage(squareRect)
    }
}

