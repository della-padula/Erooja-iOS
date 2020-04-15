//
//  GoalDetailItemInputCell.swift
//  erooja
//
//  Created by TaeinKim on 2020/04/15.
//  Copyright © 2020 김태인. All rights reserved.
//

import UIKit

public protocol GoalDetailInputDelegate {
    func returnKeyEvent(_ textField: UITextField, content: String?)
}

public class GoalDetailItemInputCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    public var delegate: GoalDetailInputDelegate?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension GoalDetailItemInputCell: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.returnKeyEvent(textField, content: textField.text)
        return true
    }
}
