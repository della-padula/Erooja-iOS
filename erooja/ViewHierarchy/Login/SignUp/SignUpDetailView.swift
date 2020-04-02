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
    
    @IBAction func onClickItem(_ sender: UIButton) {
        ELog.debug(message: "Selected Button : \(buttons?[sender.tag - 1])")
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
    }
}
