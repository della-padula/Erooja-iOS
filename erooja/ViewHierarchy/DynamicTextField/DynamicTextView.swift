//
//  DynamicTextField.swift
//  erooja
//
//  Created by 김태인 on 2020/04/07.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaUI
import EroojaCommon

class DynamicTextView: UIView {
    dynamic var textViewHeight: CGFloat = 46.0
    dynamic var text: String? = nil {
        didSet {
//            self.updateText()
        }
    }
    
    dynamic var placeholder: String? = nil {
        didSet {
//            self.updatePlaceholder()
        }
    }
    
    dynamic var statusChangedHandler: ((SettingsItemInputStatus) -> Void)?
    
    dynamic var lengthVisibility: Bool = true {
        didSet {
            self.updateLength()
            self.updateLayout()
        }
    }
    
    dynamic var maxLength: Int = 0 {
        didSet {
            self.updateLength()
            self.updateLayout()
        }
    }
    
    dynamic var maxNumberOfLines: Int = 0 {
        didSet {
            self.inputTextView.textContainer.maximumNumberOfLines = self.maxNumberOfLines
            self.updateLayout()
        }
    }
    
    dynamic var isEnabled: Bool = true {
        didSet {
            self.inputTextView.isEditable = self.isEnabled
        }
    }
    
    dynamic var returnKeyType: UIReturnKeyType {
        set {
            self.inputTextView.returnKeyType = newValue
        }
        
        get {
            return self.inputTextView.returnKeyType
        }
    }
    
    dynamic var focusOutDimming: Bool = false
    
    private var numberOfLines: Int = 0
    private var textViewHeightConstraint: NSLayoutConstraint?
    private var clearImagetTrailingConstraint: NSLayoutConstraint?
    private var underlineWidthConstraint: NSLayoutConstraint?
    private var textButtonHeightConstraint: NSLayoutConstraint?
    private var textButtonTopConstraint: NSLayoutConstraint?
    public dynamic var inputTextColor = EroojaColorSet.shared.gray200s
    public dynamic var underlineColor = UIColor.black
    
    lazy private var inputTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.showsHorizontalScrollIndicator = false
        textView.showsVerticalScrollIndicator = false
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.textContainer.maximumNumberOfLines = 0
        textView.textContainer.lineBreakMode = .byClipping
        textView.enablesReturnKeyAutomatically = true
        textView.returnKeyType = .default
        textView.font = .AppleSDRegular14P
        textView.backgroundColor = UIColor.white
        textView.textColor = self.inputTextColor
        textView.tintColor = EroojaColorSet.shared.orgDefault400s
        textView.delegate = self
        return textView
    }()
    
    lazy private var clearImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "settingsIcoClear")!
        imageView.tintColor = EroojaColorSet.shared.gray300s
        return imageView
    }()
    
    lazy private var placeholderLabel = UILabel()
    lazy private var lengthLabel = UILabel()
    lazy private var underlineView = UIView()
    
    func updateLength() {
        self.lengthLabel.text = (self.lengthVisibility && self.maxLength > 0) ? "\(self.text?.count ?? 0)/\(self.maxLength)" : nil
        self.lengthLabel.isHidden = self.lengthLabel.text.isEmptyOrNil
    }
    
    func updateUnderline() {
        if self.isEditing {
            self.underlineColor = EroojaColorSet.shared.orgDefault400s
            self.underlineWidthConstraint?.constant = 8
        } else {
            self.underlineColor = EroojaColorSet.shared.gray100s
            self.underlineWidthConstraint?.constant = 8
        }
    }
    
    func updateClearImage() {
        self.clearImageView.isHidden = !self.isEditing || self.text.isEmptyOrNil
    }
    
    func updateLayout() {
        self.clearImagetTrailingConstraint?.constant = self.lengthLabel.isHidden || self.clearImageView.isHidden ? 0 : (self.maxLength > 100 ? -50 : -35)
    }
}

extension DynamicTextView: UITextViewDelegate {
    var isEditing: Bool {
        return self.inputTextView.isFirstResponder
    }

    func textViewDidChange(_ textView: UITextView) {
        self.text = textView.text
    }
    
    func beginEditing() {
        if self.isEditing {
            return
        }
        self.inputTextView.becomeFirstResponder()
    }
    
    func endEditing() {
        if !self.isEditing {
            return
        }
        self.inputTextView.resignFirstResponder()
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.focusOutDimming {
            self.inputTextColor = EroojaColorSet.shared.gray100s
        }

//        self.updateClearImage()
//        self.updateUnderline()
//        self.updateLayout()
//        self.statusChangedHandler?([ .didBeginEditing ])
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if self.focusOutDimming {
            self.inputTextColor = EroojaColorSet.shared.gray300s
        }

//        self.updateClearImage()
//        self.updateUnderline()
//        self.updateLayout()
//        self.statusChangedHandler?([ .didEndEditing ])
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if self.maxNumberOfLines == 1, text == "\n" {
            self.endEditing()
        }
        
        var newText = textView.text ?? ""
        if let subRange = Range<String.Index>(range, in: newText) {
            newText.replaceSubrange(subRange, with: text)
        }

        return !(self.maxLength > 0 && newText.count > self.maxLength)
    }
}

struct SettingsItemInputStatus: OptionSet {
    public let rawValue: UInt
    public static let didBeginEditing = SettingsItemInputStatus(rawValue: 1 << 0)
    public static let didEndEditing = SettingsItemInputStatus(rawValue: 1 << 1)
    public static let didTapButton = SettingsItemInputStatus(rawValue: 1 << 2)
    public static let didTapClearButton = SettingsItemInputStatus(rawValue: 1 << 3)

    init(rawValue: UInt) {
        self.rawValue = rawValue
    }
}
