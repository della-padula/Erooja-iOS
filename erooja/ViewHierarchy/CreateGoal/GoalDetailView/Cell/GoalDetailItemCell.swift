//
//  GoalDetailItemCell.swift
//  erooja
//
//  Created by TaeinKim on 2020/04/15.
//  Copyright © 2020 김태인. All rights reserved.
//

import UIKit

public class GoalDetailItemCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    public var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
