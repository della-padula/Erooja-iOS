//
//  CustomNavigationBar.swift
//  EroojaUI
//
//  Created by 김태인 on 2020/04/05.
//  Copyright © 2020 김태인. All rights reserved.
//

import UIKit

public class CustomNavigationBar: UINavigationBar {
    public var navigationItemsMaskColor: UIColor = .black
    public var margin: CGFloat = 9
    
    public var customTitleColor: UIColor?
    public var useCustomMargin: Bool = true
    
    public var shadowColor: UIColor? {
        willSet(newValue) {
            guard let color = newValue else { return }
            shadowImage = UIImage(color: color, size: CGSize(width: 1, height: 1.0 / UIScreen.main.scale))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        isTranslucent = currentTranslucent
    }
}
