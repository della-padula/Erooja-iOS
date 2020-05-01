//
//  UserAPIViewController.swift
//  erooja
//
//  Created by Denny on 2020/05/01.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaUI
import EroojaCommon
import EroojaNetwork

public class UserAPIViewController: BaseViewController {
    @IBOutlet weak var existNicknameTf: UITextField!
    @IBOutlet weak var updateNicknameTf: UITextField!
    
    @IBOutlet weak var accessTokenTf: UITextField!
    @IBOutlet weak var userInfoNicknameTf: UITextField!
    @IBOutlet weak var userInfoImageURLTf: UITextField!
    
    @IBOutlet weak var nicknameLogView: UITextView!
    @IBOutlet weak var userInfoLogView: UITextView!
    
    @IBAction func onClickCheckDuplicity(_ sender: UIButton) {
        
    }
    
    @IBAction func onClickUpdateNickname(_ sender: UIButton) {
        
    }
    
    @IBAction func onClickGetUserInfo(_ sender: UIButton) {
        
    }
    
    @IBAction func onClickModifyUserInfo(_ sender: UIButton) {
        
    }

}
