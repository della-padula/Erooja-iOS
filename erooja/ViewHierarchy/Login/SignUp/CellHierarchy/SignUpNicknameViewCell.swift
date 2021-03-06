//
//  SignUpFirstViewCell.swift
//  erooja
//
//  Created by 김태인 on 2020/04/02.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import UIKit
import EroojaUI
import EroojaNetwork
import EroojaCommon
import NotificationCenter

public enum SignUpType {
    case nickname
    case field
    case detail
}

public enum FieldType: String {
    case development = "Development"
    case design = "Design"
}

public enum TextFieldErrorType: String, CaseIterable {
    case empty = "닉네임을 2자 이상 입력해주세요."
    case exceed = "2자 이상 5자 이하로 입력해주세요."
    case duplicate = "중복된 닉네임입니다."
    case success = "사용할 수 있는 닉네임입니다."
}

public class SignUpNicknameViewCell: UICollectionViewCell {
    private var isNicknameValid: Bool = false
    private var isInitialShown: Bool = true
    private let lblTitle = UILabel()
    private let lblSubTitle = UILabel()
    private let bottomHintLabel = UILabel()
    private let fieldView = UIView()
    private let bottomBorderView = UIView()
    private let textFieldView = EroojaTextField()
    private let checkBadgeView = UIImageView()
    
    public var delegate: SignUpCellDelegate?
    
    public var viewModel: SignUpViewModel? {
        didSet {
            self.title = viewModel?.title
            self.subTitle = viewModel?.subTitle
            self.viewType = viewModel?.type
        }
    }
    
    public var title: String? {
        didSet {
            self.lblTitle.text = title
        }
    }
    
    public var subTitle: String? {
        didSet {
            self.lblSubTitle.text = subTitle
        }
    }
    
    public var viewType: SignUpType? {
        didSet {
            setupDetailViewLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCell()
        self.addNotificationObserver()
    }
    
    private func addNotificationObserver() {
        NotificationCenter.default.addObserver(forName: Notification.Name(EroojaNotifications.EroojaNicknameAlreadyExist),
                                               object: nil,
                                               queue: nil) { [weak self] _ in
                                                ELog.debug("Nickname Already Exist")
                                                self?.setBadgeState(isValid: false, errorType: .duplicate)
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name(EroojaNotifications.EroojaNicknameAvailable),
                                               object: nil,
                                               queue: nil) { [weak self] _ in
                                                ELog.debug("Nickname Available")
                                                self?.setBadgeState(isValid: true, errorType: .success)
        }
    }
    
    // PUBLIC
    public func checkButtonState() {
        isInitialShown = true
        ELog.debug("isNicknameValid : \(isNicknameValid)")
        delegate?.setButtonStyle(forState: isNicknameValid ? .active : .inActive)
    }
    
    private func setupCell() {
        self.lblTitle.text = self.title ?? "NO TITLE"
        self.lblTitle.font = .SpoqaBold20P
        self.lblTitle.textAlignment = .center
        self.lblTitle.textColor = EroojaColorSet.shared.gray700
        self.addSubview(lblTitle)
        
        self.lblTitle.translatesAutoresizingMaskIntoConstraints = false
        self.lblTitle.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.lblTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        self.lblTitle.topAnchor.constraint(equalTo: topAnchor, constant: 44).isActive = true
        self.lblTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.lblTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func setupDetailViewLayout() {
        setupNicknameView()
    }
    
    private func setBadgeState(isValid: Bool, errorType: TextFieldErrorType?) {
        if isValid {
            self.isNicknameValid = true
            self.bottomHintLabel.isHidden = true
            self.checkBadgeView.isHidden = false
            self.checkBadgeView.image = UIImage(named: "signup_check")
            SignUpBaseProperty.nickname = textFieldView.text
        } else {
            self.isInitialShown = false
            
            self.bottomHintLabel.isHidden = false
            self.bottomHintLabel.text = errorType?.rawValue
            self.isNicknameValid = false
            self.checkBadgeView.isHidden = false
            self.checkBadgeView.image = UIImage(named: "signup_error")
        }
        self.delegate?.setButtonStyle(forState: isValid ? .active : .inActive)
    }
    
    private func setupNicknameView() {
        if isInitialShown {
            ELog.debug("isInitialShown : \(isInitialShown)")
            checkBadgeView.image = UIImage(named: "signup_error")
            checkBadgeView.isHidden = true
            bottomHintLabel.isHidden = true
        }
        
        fieldView.backgroundColor = .clear
        
        textFieldView.backgroundColor = .clear
        textFieldView.textAlignment = .center
        textFieldView.placeholder = "한글 2자 이상 ~ 5자 이내"
        textFieldView.debounce(delay: 0.3) { (text) in
            ELog.debug("Debounce Text : \(text ?? "nil"), Length : \(text?.count ?? 0)")
            let inputText = text ?? ""
            
            if inputText.isEmpty {
                self.bottomBorderView.backgroundColor = EroojaColorSet.shared.gray300
                self.checkBadgeView.isHidden = true
                
                if !self.isInitialShown {
                    self.bottomHintLabel.isHidden = false
                    self.bottomHintLabel.text = TextFieldErrorType.empty.rawValue
                }
            } else {
                var errorType: TextFieldErrorType?
                self.isInitialShown = false
                
                if (text ?? "").count > 5 || (text ?? "").count < 2 {
                    errorType = .exceed
                    self.bottomHintLabel.isHidden = false
                    self.bottomHintLabel.text = errorType?.rawValue
                    self.isNicknameValid = false
                    self.checkBadgeView.isHidden = false
                    self.checkBadgeView.image = UIImage(named: "signup_error")
                } else {
                    // request nickname check
                    if let text = text {
                        self.requestNicknameValidation(nickname: text)
                    }
                }
                self.bottomBorderView.backgroundColor = EroojaColorSet.shared.orgDefault400
            }
        }
        textFieldView.font = .SpoqaBold15P
        textFieldView.textColor = EroojaColorSet.shared.gray700
        
        self.addSubview(fieldView)
        fieldView.addSubview(textFieldView)
        fieldView.addSubview(checkBadgeView)
        
        fieldView.translatesAutoresizingMaskIntoConstraints = false
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        checkBadgeView.translatesAutoresizingMaskIntoConstraints = false
        
        fieldView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        fieldView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        fieldView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80).isActive = true
        fieldView.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 60).isActive = true
        
        textFieldView.topAnchor.constraint(equalTo: fieldView.topAnchor).isActive = true
        textFieldView.bottomAnchor.constraint(equalTo: fieldView.bottomAnchor).isActive = true
        textFieldView.leadingAnchor.constraint(equalTo: fieldView.leadingAnchor).isActive = true
        textFieldView.trailingAnchor.constraint(equalTo: fieldView.trailingAnchor).isActive = true
        
        checkBadgeView.topAnchor.constraint(equalTo: fieldView.topAnchor).isActive = true
        checkBadgeView.bottomAnchor.constraint(equalTo: fieldView.bottomAnchor).isActive = true
        checkBadgeView.widthAnchor.constraint(equalTo: checkBadgeView.heightAnchor).isActive = true
        checkBadgeView.trailingAnchor.constraint(equalTo: fieldView.trailingAnchor).isActive = true
        
        bottomBorderView.backgroundColor = EroojaColorSet.shared.gray300
        self.addSubview(bottomBorderView)
        bottomBorderView.translatesAutoresizingMaskIntoConstraints = false
        bottomBorderView.topAnchor.constraint(equalTo: fieldView.bottomAnchor).isActive = true
        bottomBorderView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        bottomBorderView.leadingAnchor.constraint(equalTo: fieldView.leadingAnchor).isActive = true
        bottomBorderView.trailingAnchor.constraint(equalTo: fieldView.trailingAnchor).isActive = true
        
        bottomHintLabel.font = .SpoqaRegular12P
        bottomHintLabel.textAlignment = .center
        bottomHintLabel.textColor = EroojaColorSet.shared.orgDefault400
        
        self.addSubview(bottomHintLabel)
        bottomHintLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomHintLabel.topAnchor.constraint(equalTo: bottomBorderView.bottomAnchor, constant: 12).isActive = true
        bottomHintLabel.leadingAnchor.constraint(equalTo: bottomBorderView.leadingAnchor).isActive = true
        bottomHintLabel.trailingAnchor.constraint(equalTo: bottomBorderView.trailingAnchor).isActive = true
    }
    
    private func requestNicknameValidation(nickname: String) {
        EroojaAPIRequest().requestNicknameExist(nickname: nickname, token: EroojaProperty.loadAccessToken()!, completion: { result in
            switch result {
            case .success(let isAvailable):
                if isAvailable {
                    NotificationCenter.default.post(name: Notification.Name(EroojaNotifications.EroojaNicknameAvailable), object: nil)
                } else {
                    NotificationCenter.default.post(name: Notification.Name(EroojaNotifications.EroojaNicknameAlreadyExist), object: nil)
                }
            case .failure(_):
                NotificationCenter.default.post(name: Notification.Name(EroojaNotifications.EroojaNicknameAvailable), object: nil)
            }
        })
    }
    
    private func setFieldButtonState() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
}
