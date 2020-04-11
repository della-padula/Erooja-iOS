//
//  EPlaceholderView.swift
//  EroojaUI
//
//  Created by 김태인 on 2020/04/12.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import UIKit

public class EPlaceholderView: UIView {
    private let imageView = UIImageView()
    private let textView = UILabel()
    private var imageHeightAnchor: NSLayoutConstraint?
    
    public var imageHeight: CGFloat = 100 {
        didSet {
            imageView.height = imageHeight
            if let constraint = imageHeightAnchor {
                NSLayoutConstraint.deactivate([constraint])
                imageHeightAnchor = imageView.heightAnchor.constraint(equalToConstant: imageHeight)
                imageHeightAnchor?.isActive = true
            }
        }
    }
    
    public var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    public var text: String? {
        didSet {
            textView.text = text
        }
    }
    
    public init() {
        super.init(frame: .zero)
        setViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setViewLayout() {
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageHeightAnchor = imageView.heightAnchor.constraint(equalToConstant: imageHeight)
        imageHeightAnchor?.isActive = true
        
        addSubview(textView)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        textView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
