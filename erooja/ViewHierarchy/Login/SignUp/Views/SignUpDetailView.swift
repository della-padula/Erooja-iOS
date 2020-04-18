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

public protocol SignUpDetailViewDelegate {
    func detailView(isValid: Bool)
}

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
    
    // LEFT
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    
    // RIGHT
    @IBOutlet weak var label6: UILabel!
    @IBOutlet weak var label7: UILabel!
    @IBOutlet weak var label8: UILabel!
    @IBOutlet weak var label9: UILabel!
    @IBOutlet weak var label10: UILabel!
    
    public var delegate: SignUpDetailViewDelegate?
    public var viewModel: SignUpDetailViewModel?
    
    private var labels: [UILabel]?
    private var buttons: [UIButton]?
    
    @IBAction func onClickItem(_ sender: UIButton) {
//        ELog.debug(message: "Selected Button : \(buttons?[sender.tag - 1])")
//        SignUpBaseProperty.detailSelectedIndex = sender.tag - 1
//        self.viewModel?.userTriggeredDatailItem(index: sender.tag - 1)
        SignUpBaseProperty.detailSelectedIndexList[sender.tag - 1] = !SignUpBaseProperty.detailSelectedIndexList[sender.tag - 1]
        self.setButtonStyle()
    }
    
    public var fieldType: FieldType? {
        didSet {
            setButtonStyle()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.bindView()
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func bindView() {
        viewModel?.selectedList.bind({ (selectStateList) in
            ELog.debug(message: "Bind Triggered")
            for (index, isActive) in selectStateList.enumerated() {
                ELog.debug(message: "Bind Event Triggered index : \(index), isActive : \(isActive)")
                self.setButtonState(index: index, isActive: isActive)
            }
        })
    }

    private func commonInit(){
        let view = Bundle.main.loadNibNamed(xibName, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        
        self.buttons = [self.button1, self.button2, self.button3, self.button4, self.button5, self.button6, self.button7, self.button8, self.button9, self.button10]
        
        self.labels = [self.label1, self.label2, self.label3, self.label4, self.label5, self.label6, self.label7, self.label8, self.label9, self.label10]
        
        setButtonStyle()
    }
    
    public func setButtonStyle() {
        ELog.debug(message: "setButtonStyle, \(String(describing: SignUpBaseProperty.fieldType))")
        for (index, button) in buttons!.enumerated() {
            button.isHidden = true
        }
        
        for label in labels! {
            label.isHidden = true
            label.text = ""
        }
        
        if SignUpBaseProperty.fieldType == .development {
            for (index, value) in JobType.Develop.allCases.enumerated() {
                setButtonTitle(index: index, title: value.rawValue)
            }
        } else {
            for (index, value) in JobType.Design.allCases.enumerated() {
                setButtonTitle(index: index, title: value.rawValue)
            }
        }
        
        var checkCount = 0
        for (index, isActive) in SignUpBaseProperty.detailSelectedIndexList.enumerated() {
            setButtonState(index: index, isActive: isActive)
            buttons?.last?.isHidden = true
            if isActive { checkCount += 1 }
        }
        delegate?.detailView(isValid: (checkCount > 0))
    }
    
    private func setButtonTitle(index: Int, title: String) {
        labels![index].text = title
    }
    
    private func setButtonState(index: Int, isActive: Bool) {
        if isActive {
            buttons![index].layer.cornerRadius = 8
            buttons![index].layer.borderColor = EroojaColorSet.shared.orgDefault400.cgColor
            buttons![index].layer.borderWidth = 1
            labels![index].font = .SpoqaRegular15P
            labels![index].textColor = EroojaColorSet.shared.orgDefault400
            buttons![index].isHidden = false
            labels![index].isHidden = false
        } else {
            buttons![index].layer.cornerRadius = 8
            buttons![index].layer.borderColor = EroojaColorSet.shared.gray300.cgColor
            buttons![index].layer.borderWidth = 1
            labels![index].font = .SpoqaRegular15P
            labels![index].textColor = EroojaColorSet.shared.gray500
            buttons![index].isHidden = false
            labels![index].isHidden = false
        }
    }
}

