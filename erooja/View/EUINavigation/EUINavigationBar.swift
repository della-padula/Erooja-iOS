//
//  EUINavigationBar.swift
//  erooja
//
//  Created by 김태인 on 2020/03/26.
//  Copyright © 2020 김태인. All rights reserved.
//
import UIKit
import EroojaUI

public class EUINavigationBar: UINavigationBar {
    public enum NavigationBarThemeStyle {
        case navigationBar(_ type: Int)
        case mainViewStyle(_ type: Int)
    }
    
    public var themeStyle: NavigationBarThemeStyle?
    
    @objc public var navigationItemsMaskColor: UIColor = .black
    @objc public var margin: CGFloat = 9
    
    private var backgroundImage: UIImage?
    private var currentBackgroundImage: UIImage?
    private var croppedBackgroundImages = [String: UIImage]()
    
    @objc public var backgroundImageHidden: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var navigationBarColor: UIColor {
        guard let currentBackgroundImage = currentBackgroundImage else { return .white }
        return currentBackgroundImage.averageCenterColor()
    }
    
    public var customTitleColor: UIColor?
    public var themeTitleColor: UIColor?
    
    public var useCustomMargin: Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if useCustomMargin {
            for subView: UIView in subviews {
                if #available(iOS 13.0, *) {
                    var frame = subView.frame
                    
                    if subView.description.contains("UIBarBackground") == false {
                        frame.origin.x = -margin
                        frame.size.width += (margin * 2)
                    }
                    
                    frame.size.height = self.frame.size.height - (frame.origin.y)
                    subView.frame = frame
                } else {
                    subView.layoutMargins = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: margin)
                }
            }
        }
        
        let currentTranslucent: Bool = isTranslucent
        currentBackgroundImage = availableBackgroundImage()
        setBackgroundImage(currentBackgroundImage, for: .default)
        isTranslucent = currentTranslucent
    }
    
    @objc
    public func setBackgroundImage(_ backgroundImage: UIImage?, backgroundColor: UIColor?) {
        self.backgroundImage = nil
        if backgroundImage != nil {
            self.backgroundImage = backgroundImage
        } else if backgroundColor != nil {
            self.backgroundImage = UIImage(color: backgroundColor!)!.stretchableImage(withLeftCapWidth: 0, topCapHeight: 0)
        }
        removeCroppedBackgroundImage()
        currentBackgroundImage = availableBackgroundImage()
        setBackgroundImage(currentBackgroundImage, for: .default)
    }
    
    @objc
    public func setBackgroundImage(_ backgroundImage: UIImage?, backgroundColor: UIColor?, animation option: UIView.AnimationOptions) {
        self.setBackgroundImage(backgroundImage, backgroundColor: backgroundColor)
        
        let animation = CATransition()
        animation.duration = 0.25
        let timing: CAMediaTimingFunctionName = option == .curveEaseIn ? .easeIn : .easeOut
        animation.timingFunction = CAMediaTimingFunction(name: timing)
        animation.type = .fade

        self.layer.add(animation, forKey: nil)
        UIView.animate(withDuration: 0.25, delay: 0, options: option, animations: {
            self.setBackgroundImage(self.currentBackgroundImage, for: .default)
        }, completion: nil)
    }
    
    private var defaultShadowImage: UIImage?
    private var chatRoomShadowImage: UIImage?
    private let emptyShadowImage: UIImage = UIImage(color: UIColor.clear, size: CGSize(width: 1, height: 1.0 / UIScreen.main.scale))!

    @objc
    public func setDefaultShadowImage() {
        guard shadowImage != defaultShadowImage else { return }
        shadowImage = defaultShadowImage
    }
    
    @objc
    public func setChatRoomShadowImage() {
        guard shadowImage != chatRoomShadowImage else { return }
        shadowImage = chatRoomShadowImage
    }
    
    @objc
    public func removeDefaultShadowImage() {
        guard shadowImage != emptyShadowImage else { return }
        shadowImage = emptyShadowImage
    }
    
    private func availableBackgroundImage() -> UIImage? {
        guard backgroundImageHidden == false else { return nil }
        var image: UIImage?
        if backgroundImage != nil {
            if backgroundImage?.resizingMode == .stretch {
                image = backgroundImage
            } else {
                image = croppedBackgroundImage()
            }
            if let image = image {
                navigationItemsMaskColor = image.averageCenterColor().blackOrWhiteContrastingColor()
            }
        }
        return image
    }
    
    private func croppedBackgroundImage() -> UIImage? {
        let size = CGSize(width: width, height: max(height, frame.maxY))
        let sizeString = "\(size.width)X\(size.height)"
        var image: UIImage? = croppedBackgroundImages[sizeString]
        if image == nil {
            image = backgroundImage?.scaleCroppedImage(cropSize: size, baseSize: UIScreen.main.bounds.size)
            if (image?.size.width ?? 0.0) < size.width || (image?.size.height ?? 0.0) < size.height {
                image = image?.stretchableImage(withLeftCapWidth: 0, topCapHeight: 0)
            }
            croppedBackgroundImages[sizeString] = image
        }
        return image
    }
    
    private func removeCroppedBackgroundImage() {
        croppedBackgroundImages.removeAll()
    }
    
    @objc public var shadowColor: UIColor? {
        willSet(newValue) {
            guard let color = newValue else { return }
            shadowImage = UIImage(color: color, size: CGSize(width: 1, height: 1.0 / UIScreen.main.scale))
        }
    }
}
