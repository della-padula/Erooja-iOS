//
//  CreateGoalSecondCell.swift
//  erooja
//
//  Created by 김태인 on 2020/04/12.
//  Copyright © 2020 김태인. All rights reserved.
//

import EroojaUI
import EroojaCommon

public class CreateGoalSecondCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textDescriptionLabel: UILabel!
    @IBOutlet weak var textCountLabel: UILabel!
    @IBOutlet weak var textField: EroojaTextField!
    @IBOutlet weak var textFieldBottomLine: UIView!
    @IBOutlet weak var bottomLineHeightContraint: NSLayoutConstraint!
    
    public var delegate: CreateGoalHeaderViewDelegate?
    
    public var titleText: String? {
        didSet {
            self.titleLabel.text = titleText
            self.titleLabel.font = .SpoqaBold20P
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        initializeLayout()
    }

    private func initializeLayout() {
        textField.borderStyle = .none
        textField.delegate = self
        textField.placeholder = "목표명을 입력해주세요."
        textField.font = .SpoqaRegular15P
        textField.textColor = EroojaColorSet.shared.gray700
        textField.tintColor = EroojaColorSet.shared.orgDefault400
        
        textField.debounce(delay: 0.0, callback: { text in
            self.processInputText(text: text ?? "")
        })
        
        textDescriptionLabel.text = "목표를 5자 이상 입력해주세요."
        textDescriptionLabel.font = .SpoqaRegular12P
        textDescriptionLabel.textColor = EroojaColorSet.shared.error100
        textCountLabel.textColor = EroojaColorSet.shared.gray300
        textCountLabel.font = .SpoqaRegular12P
        setBottomLineStyle(isActive: false)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onClickRightButton(_:)),
                                               name: NSNotification.Name("RightButtonClicked"),
                                               object: nil)
    }
    
    private func processInputText(text: String) {
        if !text.isEmpty && text.count > 4 && text.count < 51 {
            setInputState(isValid: true)
            CreateGoalDynamicProperty.cellValid[1] = true
            CreateGoalDynamicProperty.goalName = text
        } else {
            setInputState(isValid: false)
            CreateGoalDynamicProperty.cellValid[1] = false
            
            if text.isEmpty {
                textDescriptionLabel.isHidden = true
            }
        }
        
        textCountLabel.text = "\(text.count)/50"
    }
    
    private func setInputState(isValid: Bool) {
        setBottomLineStyle(isActive: isValid)
        textDescriptionLabel.isHidden = isValid
        
        delegate?.rightButton(at: .second, active: isValid)
    }
    
    private func setBottomLineStyle(isActive: Bool) {
        bottomLineHeightContraint.constant = 2
        textFieldBottomLine.backgroundColor = isActive ? EroojaColorSet.shared.orgDefault400 : EroojaColorSet.shared.gray300
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    @objc
    public func onClickRightButton(_ notification: Notification) -> Void {
        ELog.debug("Save Goal Content to Property")
        CreateGoalDynamicProperty.goalName = textField.text
    }
}

extension CreateGoalSecondCell: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count  - range.length
        
        return newLength < 51
    }
}
