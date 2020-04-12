//
//  TableViewCell.swift
//  erooja
//
//  Created by 김태인 on 2020/04/12.
//  Copyright © 2020 김태인. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    private let contentLabel = UILabel()
    public var title: String = "" {
        didSet {
            contentLabel.text = title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setCellLayout()
    }
    
    private func setCellLayout() {
        self.contentView.addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        contentLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        contentLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor).isActive = true
        contentLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
