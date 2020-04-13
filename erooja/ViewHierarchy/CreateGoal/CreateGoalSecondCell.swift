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
    @IBOutlet weak var textField: UITextField!
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
        textField.placeholder = "목표명을 입력해주세요."
        textField.textColor = EroojaColorSet.shared.gray100s
        textField.tintColor = EroojaColorSet.shared.orgDefault400s
        
        setBottomLineStyle(isActive: false)
    }
    
    private func setBottomLineStyle(isActive: Bool) {
        bottomLineHeightContraint.constant = isActive ? 4 : 2
        textFieldBottomLine.backgroundColor = isActive ? EroojaColorSet.shared.orgDefault400s : EroojaColorSet.shared.gray500s
    }
}
