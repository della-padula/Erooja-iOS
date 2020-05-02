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
    @IBOutlet weak var existNicknameAccessTokenTf: UITextField!
    
    @IBOutlet weak var accessTokenTf: UITextField!
    @IBOutlet weak var userInfoNicknameTf: UITextField!
    @IBOutlet weak var userInfoImageURLTf: UITextField!
    
    @IBOutlet weak var nicknameLogView: UITextView!
    @IBOutlet weak var userInfoLogView: UITextView!
    
    @IBAction func onClickCheckDuplicity(_ sender: UIButton) {
        guard let nickname = existNicknameTf.text, let token = existNicknameAccessTokenTf.text else {
            nicknameLogView.text = "Please enter your nickname and access token."
            return
        }
        
        EroojaAPIRequest().requestNicknameExist(nickname: nickname, token: token, completion: { result in
            switch result {
            case .success(let isExist):
                self.nicknameLogView.text = "isExist : \(isExist)"
            case .failure(let error):
                self.nicknameLogView.text = " \(error.localizedDescription)"
            }
        })
    }
    
    @IBAction func onClickUpdateNickname(_ sender: UIButton) {
        guard let nickname = updateNicknameTf.text, let token = existNicknameAccessTokenTf.text else {
            nicknameLogView.text = "Please enter your nickname and access token."
            return
        }
        
        EroojaAPIRequest().requestNicknameUpdate(nickname: nickname, token: token, completion: { result in
            switch result {
            case .success(let responseValue):
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: responseValue, options: .prettyPrinted)
                    
                    let userInfo = try decoder.decode(UserModel.self, from: jsonData)
                    var debugLogText = ""
                    debugLogText += "uid : \(userInfo.uid)\n"
                    debugLogText += "nickname : \(userInfo.nickname)\n"
                    debugLogText += "imagePath : \(userInfo.imagePath)"
                    
                    self.nicknameLogView.text = debugLogText
                } catch {
                    var debugLogText = ""
                    let message: String = (responseValue["message"] as? String) ?? ""
                    debugLogText += "\(responseValue["status"])\n"
                    debugLogText += "\(message.removingPercentEncoding)\n"
                    debugLogText += "JSON Decode Error"
                    self.nicknameLogView.text = debugLogText
                }
            case .failure(let error):
                self.nicknameLogView.text = error.localizedDescription
            }
        })
    }
    
    @IBAction func onClickGetUserInfo(_ sender: UIButton) {
        
    }
    
    @IBAction func onClickModifyUserInfo(_ sender: UIButton) {
        
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
