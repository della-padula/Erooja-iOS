//
//  GoalDetailItemInputCell.swift
//  erooja
//
//  Created by TaeinKim on 2020/04/15.
//  Copyright © 2020 김태인. All rights reserved.
//

import EroojaUI

public protocol GoalDetailInputDelegate {
    func returnKeyEvent(_ textField: UITextField, content: String?)
}

public class GoalDetailItemInputCell: UITableViewCell {

    @IBOutlet weak var bgColorView: UIView!
    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var textField: EroojaTextField!
    
    public var delegate: GoalDetailInputDelegate?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.setViewLayout()
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setViewLayout() {
        dotView.layer.cornerRadius = dotView.bounds.width / 2
        bgColorView.layer.cornerRadius = 12
        bgColorView.backgroundColor = EroojaColorSet.shared.grayBg700s
        textField.delegate = self
        textField.debounce(delay: 0, callback: { text in
            if (text ?? "").isEmpty {
                self.dotView.backgroundColor = EroojaColorSet.shared.gray400s
            } else {
                self.dotView.backgroundColor = EroojaColorSet.shared.orgDefault400s
            }
        })
    }
    
}

extension GoalDetailItemInputCell: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.returnKeyEvent(textField, content: textField.text)
        textField.text = ""
        self.dotView.backgroundColor = EroojaColorSet.shared.gray400s
        return true
    }
}
