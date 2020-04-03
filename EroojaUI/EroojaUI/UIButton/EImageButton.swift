//
//  EImageButton.swift
//  EroojaUI
//
//  Created by 김태인 on 2020/04/03.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import UIKit

public class EImageButton: UIView {
    private var button    = UIButton()
    private var imageView = UIImageView()
    
    public init() {
        super.init(frame: .zero)
        
        addSubview(imageView)
        addSubview(button)
        setButtonLayout()
    }
    
    public var image: UIImage? {
        didSet {
            setButtonStyle()
        }
    }
    
    public var padding: CGFloat = 0 {
        didSet {
            setButtonLayout()
        }
    }
    
    public func addTarget(target: Any?, action: Selector, forEvent: UIControl.Event) {
        button.addTarget(target, action: action, for: forEvent)
    }
    
    private func setButtonLayout() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: padding).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding).isActive = true
        
        button.topAnchor.constraint(equalTo: topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    private func setButtonStyle() {
        imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
