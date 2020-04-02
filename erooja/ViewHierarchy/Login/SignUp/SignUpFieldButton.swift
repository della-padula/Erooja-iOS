//
//  SignUpFieldButton.swift
//  erooja
//
//  Created by 김태인 on 2020/04/02.
//  Copyright © 2020 김태인. All rights reserved.
//

import UIKit
import EroojaUI

public struct Field {
    public var type: SignUpViewCell.FieldType
    public var title: String
    public var isActive: Bool
    public var imageOn: UIImage
    public var imageOff: UIImage
}

public protocol SignUpFieldButtonDelegate {
    func fieldButton(selectedFieldType: SignUpViewCell.FieldType)
}

public class SignUpFieldButton: UIView {
    private let xibName = "SignUpFieldButton"
    
    @IBAction func onClickField(_ sender: Any) {
        self.isActive = !self.isActive
        delegate?.fieldButton(selectedFieldType: field?.type ?? .development)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    public var delegate: SignUpFieldButtonDelegate?
    public var index: Int?
    public var isActive: Bool = false {
        didSet {
            if isActive {
                self.imageView.image = field?.imageOn
            } else {
                self.imageView.image = field?.imageOff
            }
        }
    }
    
    public var field: Field? {
        didSet {
            self.isActive = field?.isActive ?? false
            setViewStyle()
        }
    }
    
    private func setViewStyle() {
        self.nameLabel.font = .AppleSDBold15P
        self.nameLabel.text = field?.title
        self.nameLabel.textColor = EroojaColorSet.shared.gray300s
        
        if field?.isActive ?? false {
            self.imageView.image = field?.imageOn
        } else {
            self.imageView.image = field?.imageOff
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func commonInit(){
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
}
