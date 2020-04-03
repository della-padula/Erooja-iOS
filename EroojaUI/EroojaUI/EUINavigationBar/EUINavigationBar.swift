//
//  ENavigationBar.swift
//  EroojaUI
//
//  Created by 김태인 on 2020/04/03.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import UIKit

public enum EBarOption {
    case backButton
    case textField
    case rightSecondButton
    case rightFirstButton
    case progressBar
}

public enum EBackButtonType {
    case back
    case close
}

public enum ERightButtonType {
    case image
    case text
}

public protocol EUINavigationBarDelegate {
    func onClickBackButton()
    
    func onClickRightSectionButton(at index: Int)
    
}


public class EUINavigationBar: UIView {
    public var barOptions: [EBarOption]? {
        didSet {
            self.setNavigationBarOption()
        }
    }
    public var delegate: EUINavigationBarDelegate?
    private var backButton = EImageButton()
    
    public init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Progress Value Setting
    public func setProgressValue(value: CGFloat) {
        
    }
    
    // Get Text Field Data
    public func getTextFieldData() -> String? {
        return nil
    }
    
    private func setNavigationBarOption() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 44).isActive = true
        topAnchor.constraint(equalTo: topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        if let options = barOptions {
            for option in options {
                switch option {
                case .backButton:
                    self.addBackButton()
                    break
                case .progressBar:
                    break
                case .rightFirstButton:
                    break
                case .rightSecondButton:
                    break
                case .textField:
                    break
                }
            }
        }
    }
    
    private func addBackButton() {
        self.backButton.image = UIImage(named: "back_button")!
        self.backButton.addTarget(target: self, action: #selector(onClickBackButton), forEvent: .touchUpInside)
        
        addSubview(self.backButton)
        
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        self.backButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        self.backButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        self.backButton.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        self.backButton.widthAnchor.constraint(equalTo: self.backButton.heightAnchor).isActive = true
    }
    
    private func addRightFirstButton() {
        
    }
    
    private func addRightSecondButton() {
        
    }
    
    @objc
    private func onClickBackButton() {
        self.delegate?.onClickBackButton()
    }
}
