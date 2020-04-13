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
    
    public var titleText: String? {
        didSet {
            self.titleLabel.text = titleText
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
        textField.textColor = EroojaColorSet.shared.gray100s
        textField.tintColor = EroojaColorSet.shared.orgDefault400s
        
        textField.debounce(delay: 0.0, callback: { text in
            self.processInputText(text: text ?? "")
        })
        
        textDescriptionLabel.textColor = EroojaColorSet.shared.error000s
        textCountLabel.textColor = EroojaColorSet.shared.gray400s
        setBottomLineStyle(isActive: false)
    }
    
    private func processInputText(text: String) {
        if text.count > 50 {
            
        }
        textCountLabel.text = "\(text.count)/50"
    }
    
    private func setBottomLineStyle(isActive: Bool) {
        bottomLineHeightContraint.constant = isActive ? 4 : 2
        textFieldBottomLine.backgroundColor = isActive ? EroojaColorSet.shared.orgDefault400s : EroojaColorSet.shared.gray500s
    }
}

extension CreateGoalSecondCell: UITextFieldDelegate {
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count  - range.length
        
        return newLength < 51
    }
}
