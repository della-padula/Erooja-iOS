//
//  AccessTokenTestViewController.swift
//  erooja
//
//  Created by Denny on 2020/05/01.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaCommon
import EroojaNetwork

public class AccessTokenViewController: BaseViewController {
    @IBOutlet weak var tfKakaoId: UITextField!
    @IBOutlet weak var tfRefreshToken: UITextField!
    
    @IBOutlet weak var genTokenTextView: UITextView!
    @IBOutlet weak var refreshTokenTextView: UITextView!
    
    @IBAction func onClickGenerateToken(_ sender: UIButton) {
        if (tfKakaoId.text ?? "").isEmpty {
            self.genTokenTextView.text = "Please enter your Kakao Id."
        } else {
            EroojaAPIRequest().requestTokenByKakao(id: tfKakaoId.text, accessToken: nil, completion: { result in
                switch result {
                case .success(let responseValue):
                    do {
                        let decoder = JSONDecoder()
                        let jsonData = try JSONSerialization.data(withJSONObject: responseValue, options: .prettyPrinted)
                        
                        let tokenInfo = try decoder.decode(TokenModel.self, from: jsonData)
                        var debugLogText = ""
                        debugLogText += "\(String(describing: self)) Token : \(tokenInfo.token)\n"
                        debugLogText += "\(String(describing: self)) RefreshToken : \(tokenInfo.refreshToken)\n"
                        debugLogText += "\(String(describing: self)) isAdditionalInfoNeeded : \(tokenInfo.isAdditionalInfoNeeded)"
                        
                        self.genTokenTextView.text = debugLogText
                    } catch {
                        var debugLogText = ""
                        let message: String = (responseValue["message"] as? String) ?? ""
                        debugLogText += "\(String(describing: self)) \(responseValue["status"])\n"
                        debugLogText += "\(String(describing: self)) \(message.removingPercentEncoding)\n"
                        debugLogText += "\(String(describing: self)) JSON Decode Error"
                        self.genTokenTextView.text = debugLogText
                    }
                case .failure(let error):
                    self.genTokenTextView.text = error.localizedDescription
                }
            })
        }
    }
    
    @IBAction func onClickRefreshToken(_ sender: UIButton) {
        guard let token = tfRefreshToken.text else {
            self.refreshTokenTextView.text = "Please enter your Refresh Token"
            return
        }
        EroojaAPIRequest().refreshAccessToken(token: token, completion: { result in
            switch result {
            case .success(let responseValue):
                do {
                    let decoder = JSONDecoder()
                    let jsonData = try JSONSerialization.data(withJSONObject: responseValue, options: .prettyPrinted)
                    
                    let tokenInfo = try decoder.decode(TokenModel.self, from: jsonData)
                    var debugLogText = ""
                    debugLogText += "\(String(describing: self)) Token : \(tokenInfo.token)\n"
                    debugLogText += "\(String(describing: self)) RefreshToken : \(tokenInfo.refreshToken)\n"
                    debugLogText += "\(String(describing: self)) isAdditionalInfoNeeded : \(tokenInfo.isAdditionalInfoNeeded)"
                    
                    self.refreshTokenTextView.text = debugLogText
                } catch {
                    var debugLogText = ""
                    let message: String = (responseValue["message"] as? String) ?? ""
                    debugLogText += "\(String(describing: self)) \(responseValue["status"])\n"
                    debugLogText += "\(String(describing: self)) \(message.removingPercentEncoding)\n"
                    debugLogText += "\(String(describing: self)) JSON Decode Error"
                    self.refreshTokenTextView.text = debugLogText
                }
            case .failure(let error):
                self.refreshTokenTextView.text = error.localizedDescription
            }
        })
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
}
