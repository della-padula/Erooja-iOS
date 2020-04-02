//
//  SignUpDetailView.swift
//  erooja
//
//  Created by 김태인 on 2020/04/03.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaUI
import EroojaCommon

public class SignUpDetailView: UIView {
    private let xibName = "SignUpDetailView"
    
    // LEFT
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button9: UIButton!
    
    // RIGHT
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button10: UIButton!
    
    private var buttons: [UIButton]?
    private var selectedIndex = -1
    
    @IBAction func onClickItem(_ sender: UIButton) {
//        ELog.debug(message: "Selected Button : \(buttons?[sender.tag - 1])")
        self.selectedIndex = sender.tag - 1
        self.setButtonStyle()
    }
    
    public var fieldType: FieldType? {
        didSet {
            setButtonStyle()
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
        
        self.buttons = [self.button1, self.button2, self.button3, self.button4, self.button5, self.button6, self.button7, self.button8, self.button9, self.button10]
        
        setButtonStyle()
    }
    
    private func setButtonStyle() {
        for button in buttons! {
            button.isHidden = true
        }
        
        if fieldType == .development {
            for (index, _) in JobType.Develop.allCases.enumerated() {
                setButtonState(index: index, isActive: false)
            }
        } else {
            for (index, _) in JobType.Design.allCases.enumerated() {
                setButtonState(index: index, isActive: false)
            }
        }
        
        if selectedIndex > -1 {
            setButtonState(index: selectedIndex, isActive: true)
        }
    }
    
    private func setButtonState(index: Int, isActive: Bool) {
        if isActive {
            buttons![index].layer.cornerRadius = 8
            buttons![index].layer.borderColor = EroojaColorSet.shared.orgDefault400s.cgColor
            buttons![index].layer.borderWidth = 1
            buttons![index].titleLabel?.font = .AppleSDSemiBold15P
            buttons![index].setTitleColor(EroojaColorSet.shared.orgDefault400s, for: .normal)
            buttons![index].isHidden = false
        } else {
            buttons![index].layer.cornerRadius = 8
            buttons![index].layer.borderColor = EroojaColorSet.shared.gray500s.cgColor
            buttons![index].layer.borderWidth = 1
            buttons![index].titleLabel?.font = .AppleSDSemiBold15P
            buttons![index].setTitleColor(EroojaColorSet.shared.gray300s, for: .normal)
            buttons![index].isHidden = false
        }
    }
}
