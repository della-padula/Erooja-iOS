//
//  ENavigationBar.swift
//  EroojaUI
//
//  Created by 김태인 on 2020/04/03.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import UIKit
import EroojaCommon

public enum EBarOption {
    case backButton
    case textField
    case rightSecondButton
    case rightFirstButton
    case progressBar
}

public enum ERightButton {
    public enum Position {
        case first
        case second
    }
    
    public enum ButtonType {
        case image
        case text
    }
}

public enum EBackButton {
    public enum ButtonType {
        case back
        case close
    }
}

public protocol EUINavigationBarDelegate {
    func onClickBackButton()
    
    func didChangeTextField(_ textField: EroojaTextField, text: String?)
    
    func onClickRightSectionButton(at position: ERightButton.Position)
}

public class EUIHeaderView: UIView {
    private var textField = EroojaTextField()
    private var backButton = EButton()
    private var rightFirstButton = EButton()
    private var rightSecondButton = EButton()
    private var progressView = UIProgressView()
    private var viewHeight: CGFloat = 44
    private var viewHeightAnchor: NSLayoutConstraint?
    
    private var rightButtons: [EButton]?
    
    private var isHiddenRightFirstButton = false
    private var isHiddenRightSecondButton = false
    
    // USER Property
    public var delegate: EUINavigationBarDelegate?
    
    public var barOptions: [EBarOption]? {
        didSet {
            self.setNavigationBarOption()
        }
    }
    
    public var textFieldPlaceholder: String? {
        didSet {
            self.textField.placeholder = textFieldPlaceholder
        }
    }
    
    public var backButtonType: EBackButton.ButtonType? {
        didSet {
            
        }
    }
    
    public var rightFirstButtonType: ERightButton.ButtonType? {
        didSet {
            self.rightButtons?[0].setButtonType(buttonType: rightFirstButtonType!)
        }
    }
    
    public var rightSecondButtonType: ERightButton.ButtonType? {
        didSet {
            self.rightButtons?[1].setButtonType(buttonType: rightSecondButtonType!)
        }
    }
    
    // MARK: USER Method
    public func setTextFieldText(text: String) {
        self.textField.text = text
    }
    
    // Set Right Button Content
    public func setRightButtonActive(position: ERightButton.Position, isActive: Bool) {
        if position == .first {
            self.rightFirstButton.isActive = isActive
        } else {
            self.rightSecondButton.isActive = isActive
        }
    }
    
    public func setRightButtonColor(position: ERightButton.Position, colorActive: UIColor, colorInActive: UIColor) {
        if position == .first {
            self.rightFirstButton.activeColor = colorActive
            self.rightFirstButton.inActiveColor = colorInActive
        } else {
            self.rightSecondButton.activeColor = colorActive
            self.rightSecondButton.inActiveColor = colorInActive
        }
    }
    
    public func setRightButtonFont(position: ERightButton.Position, font: UIFont) {
        if position == .first {
            self.rightFirstButton.font = font
        } else {
            self.rightSecondButton.font = font
        }
    }
    
    public func setBackButtonImage(image: UIImage) {
        self.backButton.image = image
    }
    
    public func setRightButtonImage(position: ERightButton.Position, image: UIImage) {
        if position == .first {
            self.rightFirstButton.image = image
        } else {
            self.rightSecondButton.image = image
        }
    }
    
    public func setRightButtonTitle(position: ERightButton.Position, title: String) {
        if position == .first {
            self.rightFirstButton.title = title
        } else {
            self.rightSecondButton.title = title
        }
    }
    
    // Progress Value Setting
    public func setProgressValue(value: CGFloat) {
        ELog.debug("value : \(value)")
        self.progressView.setProgress(Float(value), animated: true)
    }
    
    // Get Text Field Data
    public func getTextFieldData() -> String? {
        return nil
    }
    
    public init() {
        super.init(frame: .zero)
        self.addSubview(rightFirstButton)
        self.addSubview(rightSecondButton)
        
        self.rightButtons = [self.rightFirstButton, self.rightSecondButton]
        
        self.setNavigationBarOption()
    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
        self.addSubview(rightFirstButton)
        self.addSubview(rightSecondButton)
        
        self.rightButtons = [self.rightFirstButton, self.rightSecondButton]
        
        self.setNavigationBarOption()
    }
    
    private func setNavigationBarOption() {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.setRightButtonLayout()
        
        if let options = barOptions {
            for option in options {
                switch option {
                case .backButton:
                    self.addBackButton()
                case .progressBar:
                    viewHeight = 46
                    setProgressBarLayout()
                case .rightFirstButton:
                    isHiddenRightFirstButton = true
                    addRightButton(position: .first)
                case .rightSecondButton:
                    isHiddenRightSecondButton = true
                    addRightButton(position: .second)
                case .textField:
                    setTextFieldLayout()
                }
            }
        }
        
        viewHeightAnchor = heightAnchor.constraint(equalToConstant: viewHeight)
        viewHeightAnchor?.isActive = true
        
        ELog.debug("Header Height : \(viewHeight)")
    }
    
    private func setRightButtonStyle(type: ERightButton.ButtonType, position: Int) {
        rightButtons?[position].setButtonType(buttonType: type)
    }
    
    private func setProgressBarLayout() {
        progressView.trackTintColor = EroojaColorSet.shared.gray100
        progressView.progressTintColor = EroojaColorSet.shared.orgDefault400
        
        addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        progressView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        progressView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    private func setTextFieldLayout() {
        addSubview(textField)
        textField.font = .SpoqaRegular14P
        textField.tintColor = EroojaColorSet.shared.orgDefault400
        textField.delegate = self
        textField.debounce(delay: 0.3, callback: { text in
            self.delegate?.didChangeTextField(self.textField, text: text)
        })
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([textField.leadingAnchor.constraint(equalTo: backButton.trailingAnchor)])
        NSLayoutConstraint.activate([textField.trailingAnchor.constraint(equalTo: rightFirstButton.leadingAnchor)])
        NSLayoutConstraint.activate([textField.heightAnchor.constraint(equalTo: heightAnchor)])
        NSLayoutConstraint.activate([textField.centerYAnchor.constraint(equalTo: centerYAnchor)])
    }
    
    private func setRightButtonLayout() {
//        rightFirstButton.backgroundColor = .red
//        rightSecondButton.backgroundColor = .blue
        
        rightFirstButton.addTarget(target: self, action: #selector(onClickRightFirstButton), forEvent: .touchUpInside)
        rightSecondButton.addTarget(target: self, action: #selector(onClickRightSecondButton), forEvent: .touchUpInside)
        
        rightFirstButton.translatesAutoresizingMaskIntoConstraints = false
        rightSecondButton.translatesAutoresizingMaskIntoConstraints = false
        
        rightSecondButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        rightSecondButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        rightFirstButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        rightSecondButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        rightFirstButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        rightSecondButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        rightFirstButton.trailingAnchor.constraint(equalTo: rightSecondButton.leadingAnchor).isActive = true
        rightFirstButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        rightFirstButton.widthAnchor.constraint(equalTo: rightFirstButton.heightAnchor, multiplier: 1.0).isActive = true
        rightSecondButton.widthAnchor.constraint(equalTo: rightSecondButton.heightAnchor, multiplier: 1.0).isActive = true
        
        rightFirstButton.isHidden = true
        rightSecondButton.isHidden = true
    }
    
    private func addRightButton(position: ERightButton.Position) {
        if position == .first {
            rightFirstButton.isHidden = false
        } else {
            rightSecondButton.isHidden = false
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
    
    @objc
    private func onClickRightFirstButton() {
        delegate?.onClickRightSectionButton(at: .first)
    }
    
    @objc
    private func onClickRightSecondButton() {
        delegate?.onClickRightSectionButton(at: .second)
    }
}

extension EUIHeaderView: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        ELog.debug("Begin Editing")
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        ELog.debug("End Editing")
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
