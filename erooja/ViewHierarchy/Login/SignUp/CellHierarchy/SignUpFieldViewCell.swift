//
//  SignUpFieldViewCell.swift
//  erooja
//
//  Created by 김태인 on 2020/04/03.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaUI
import EroojaCommon

public class SignUpFieldViewCell: UICollectionViewCell {
    private var isFieldValid: Bool = false
    private let lblTitle = UILabel()
    
    private let fieldView = UIView()
    private let fieldDevelopmentView = SignUpFieldButton()
    private let fieldDesignView      = SignUpFieldButton()
    
    private var fieldButtonModels = [
        Field(type: .development, title: "개발 직군", isActive: false, imageOn: .signup_field_dev_on, imageOff: .signup_field_dev_off),
        Field(type: .design,title: "디자인 직군", isActive: false, imageOn: .signup_field_design_on, imageOff: .signup_field_design_off)
    ]
    
    public var delegate: SignUpCellDelegate?
    
    private var fieldType: FieldType? {
        didSet {
            if fieldType == .development {
                fieldDevelopmentView.isActive = true
                fieldDesignView.isActive = false
                self.delegate?.setButtonStyle(forState: .active)
            } else if  fieldType == .design {
                fieldDevelopmentView.isActive = false
                fieldDesignView.isActive = true
                self.delegate?.setButtonStyle(forState: .active)
            } else {
                self.delegate?.setButtonStyle(forState: .inActive)
            }
        }
    }
    
    public var viewModel: SignUpViewModel? {
        didSet {
            self.title = viewModel?.title
        }
    }
    
    public var title: String? {
        didSet {
            self.lblTitle.text = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCell()
        self.setupFieldView()
        self.checkButtonState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        self.lblTitle.text = self.title ?? "NO TITLE"
        self.lblTitle.font = .AppleSDBold20P
        self.lblTitle.textAlignment = .center
        self.lblTitle.textColor = EroojaColorSet.shared.gray100s
        self.addSubview(lblTitle)
        
        self.lblTitle.translatesAutoresizingMaskIntoConstraints = false
        self.lblTitle.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.lblTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        self.lblTitle.topAnchor.constraint(equalTo: topAnchor, constant: 44).isActive = true
        self.lblTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.lblTitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func setupFieldView() {
        fieldDevelopmentView.delegate = self
        fieldDesignView.delegate = self
        
        self.addSubview(fieldView)
        
        fieldView.addSubview(fieldDevelopmentView)
        fieldView.addSubview(fieldDesignView)
        
        fieldView.translatesAutoresizingMaskIntoConstraints = false
        fieldDevelopmentView.translatesAutoresizingMaskIntoConstraints = false
        fieldDesignView.translatesAutoresizingMaskIntoConstraints = false
        
        fieldView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        fieldView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        fieldView.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 20).isActive = true
        fieldView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40).isActive = true
        
        fieldDevelopmentView.field = fieldButtonModels[0]
        fieldDesignView.field = fieldButtonModels[1]
        fieldDevelopmentView.index = 0
        fieldDesignView.index = 1
        
        fieldDevelopmentView.topAnchor.constraint(equalTo: fieldView.topAnchor).isActive = true
        fieldDevelopmentView.leadingAnchor.constraint(equalTo: fieldView.leadingAnchor).isActive = true
        fieldDevelopmentView.trailingAnchor.constraint(equalTo: fieldView.trailingAnchor).isActive = true
        fieldDevelopmentView.heightAnchor.constraint(equalTo: fieldView.heightAnchor, multiplier: 0.5).isActive = true
        
        fieldDesignView.topAnchor.constraint(equalTo: fieldDevelopmentView.bottomAnchor).isActive = true
        fieldDesignView.leadingAnchor.constraint(equalTo: fieldView.leadingAnchor).isActive = true
        fieldDesignView.trailingAnchor.constraint(equalTo: fieldView.trailingAnchor).isActive = true
        fieldDesignView.bottomAnchor.constraint(equalTo: fieldView.bottomAnchor).isActive = true
        fieldDesignView.heightAnchor.constraint(equalTo: fieldView.heightAnchor, multiplier: 0.5).isActive = true
        
    }
    
    public func checkButtonState() {
        delegate?.setButtonStyle(forState: isFieldValid ? .active : .inActive)
    }
}

extension SignUpFieldViewCell: SignUpFieldButtonDelegate {
    public func fieldButton(selectedFieldType: FieldType) {
        ELog.debug(message: "Selected : \(selectedFieldType)")
        
        self.setButtonState(fieldType: selectedFieldType)
        self.isFieldValid = true
        self.checkButtonState()
    }
    
    private func setButtonState(fieldType: FieldType) {
        if SignUpBaseProperty.fieldType != fieldType {
            SignUpBaseProperty.isReloadDetailCell = true
//            SignUpBaseProperty.detailSelectedIndex = -1
        } else {
            SignUpBaseProperty.isReloadDetailCell = false
        }
        
        if fieldType == .development {
            SignUpBaseProperty.fieldType = .development
            fieldDevelopmentView.isActive = true
            fieldDesignView.isActive = false
        } else {
            SignUpBaseProperty.fieldType = .design
            fieldDevelopmentView.isActive = false
            fieldDesignView.isActive = true
        }
    }
}
