//
//  ModalView.swift
//  erooja
//
//  Created by 김태인 on 2020/04/03.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaUI
import EroojaCommon

public class EUIModalViewController: BaseViewController {
    private var imageButton = EButton()
    private var bottomButton = EButton()
    
    private var imageBackgroundView = UIImageView()
    private var imageForegroundLogo = UIImageView()
    
    private var modalTitleLabel = UILabel()
    private var modalContentLabel = UILabel()
    
    private var imageForegroundLogoTopAnchor: NSLayoutConstraint?
    private var imageForegroundLogoHeightAnchor: NSLayoutConstraint?
    
    public var foregroundLogoHeightMultiplier: CGFloat = (227 / 160) {
        didSet {
            if imageForegroundLogoHeightAnchor != nil {
                NSLayoutConstraint.deactivate([imageForegroundLogoHeightAnchor!])
            }
            imageForegroundLogoHeightAnchor = imageForegroundLogo.heightAnchor.constraint(equalTo: imageForegroundLogo.widthAnchor, multiplier: foregroundLogoHeightMultiplier)
            NSLayoutConstraint.activate([imageForegroundLogoTopAnchor!])
        }
    }
    
    public var foregroundLogoTopAnchor: CGFloat = 160 {
        didSet {
            if imageForegroundLogoTopAnchor != nil {
                NSLayoutConstraint.deactivate([imageForegroundLogoTopAnchor!])
            }
            
            imageForegroundLogoTopAnchor = imageForegroundLogo.heightAnchor.constraint(equalToConstant: foregroundLogoTopAnchor)
            NSLayoutConstraint.activate([imageForegroundLogoTopAnchor!])
        }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setViewLayout()
    }
    
    private func setViewLayout() {
        imageButton.image = .commonIcoClose
        imageButton.padding = 10
        
        // For DEBUG
        imageButton.backgroundColor = .green
        imageForegroundLogo.backgroundColor = .green
        
        imageButton.addTarget(target: self, action: #selector(onClickCloseButton), forEvent: .touchUpInside)
        
        imageBackgroundView.image = .modalBackground
        imageBackgroundView.contentMode = .scaleToFill
        
        self.view.addSubview(imageButton)
        self.view.addSubview(bottomButton)
        self.view.addSubview(imageBackgroundView)
        self.view.bringSubviewToFront(imageButton)
        
        self.view.addSubview(modalTitleLabel)
        self.view.addSubview(modalContentLabel)
        self.view.addSubview(imageForegroundLogo)
        
        // 5: 6 = x : y
        
        // 5y = 6x
        // y = 6 / 5 (x)
        
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        modalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        modalContentLabel.translatesAutoresizingMaskIntoConstraints = false
        imageForegroundLogo.translatesAutoresizingMaskIntoConstraints = false
        imageBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        imageButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        imageButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageButton.widthAnchor.constraint(equalTo: imageButton.heightAnchor, multiplier: 1.0).isActive = true
        
        imageBackgroundView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageBackgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageBackgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        imageBackgroundView.heightAnchor.constraint(equalTo: imageBackgroundView.widthAnchor, multiplier: 306/360).isActive = true

        imageForegroundLogo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageForegroundLogo.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        
        imageForegroundLogoTopAnchor = imageForegroundLogo.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: foregroundLogoTopAnchor)
        imageForegroundLogoHeightAnchor = imageForegroundLogo.heightAnchor.constraint(equalTo: imageForegroundLogo.widthAnchor, multiplier: foregroundLogoHeightMultiplier)
        NSLayoutConstraint.activate([imageForegroundLogoTopAnchor!, imageForegroundLogoHeightAnchor!])
    }
    
    @objc
    public func onClickCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
}
