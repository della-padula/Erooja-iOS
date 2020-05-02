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
    
    @IBOutlet weak var lblImageFileName: UILabel!
    @IBOutlet weak var uploadImageTokenTf: UITextField!
    @IBOutlet weak var imageUploadLogView: UITextView!
    
    private let picker = UIImagePickerController()
    private var imageData: Data?
    
    @IBAction func onClickCheckDuplicity(_ sender: UIButton) {
        self.view.endEditing(true)
        guard let nickname = existNicknameTf.text, let token = existNicknameAccessTokenTf.text else {
            nicknameLogView.text = "Please enter your nickname and access token."
            return
        }
        
        if nickname.isEmpty || token.isEmpty {
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
        self.view.endEditing(true)
        guard let nickname = updateNicknameTf.text, let token = existNicknameAccessTokenTf.text else {
            nicknameLogView.text = "Please enter your nickname and access token."
            return
        }
        
        if nickname.isEmpty || token.isEmpty {
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
        self.view.endEditing(true)
        
        if let token = accessTokenTf.text {
            if token.isEmpty {
                userInfoLogView.text = "Token을 입력해주세요."
            }
            
            EroojaAPIRequest().requestGetUserInfo(token: token, completion: { result in
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
                        
                        self.userInfoLogView.text = debugLogText
                    } catch {
                        var debugLogText = ""
                        let message: String = (responseValue["message"] as? String) ?? ""
                        debugLogText += "\(responseValue["status"])\n"
                        debugLogText += "\(message.removingPercentEncoding)\n"
                        debugLogText += "JSON Decode Error"
                        self.userInfoLogView.text = debugLogText
                    }
                case .failure(let error):
                    self.userInfoLogView.text = error.localizedDescription
                }
            })
        }
    }
    
    @IBAction func onClickModifyUserInfo(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if let token = accessTokenTf.text, let nickname = userInfoNicknameTf.text, let imageURL = userInfoImageURLTf.text {
            if token.isEmpty || nickname.isEmpty || imageURL.isEmpty {
                userInfoLogView.text = "하나 이상의 입력되지 않은 값이 있습니다."
                return
            }
            EroojaAPIRequest().requestUpdateUserInfo(nickname: nickname, imageURL: imageURL, token: token, completion: { result in
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
                        
                        self.userInfoLogView.text = debugLogText
                    } catch {
                        var debugLogText = ""
                        let message: String = (responseValue["message"] as? String) ?? ""
                        debugLogText += "\(responseValue["status"])\n"
                        debugLogText += "\(message.removingPercentEncoding)\n"
                        debugLogText += "JSON Decode Error"
                        self.userInfoLogView.text = debugLogText
                    }
                case .failure(let error):
                    self.userInfoLogView.text = error.localizedDescription
                }
            })
        }
    }
    
    @IBAction func onClickGetProfileHistory(_ sender: UIButton) {
        self.view.endEditing(true)
        if let token = accessTokenTf.text {
            if token.isEmpty {
                userInfoLogView.text = "Token을 입력해주세요."
                return
            }
            
            EroojaAPIRequest().requestProfileImageHistory(token: token, completion: { result in
                switch result {
                case .success(let imageList):
                    var debugLogText = ""
                    for url in imageList {
                        debugLogText += url
                        debugLogText += "\n"
                    }
                    self.userInfoLogView.text = debugLogText
                case .failure(_):
                    self.userInfoLogView.text = "URL Request Failed"
                }
            })
        }
    }
    
    @IBAction func onClickLoadImage(_ sender: UIButton) {
        showLoadImageAlertView()
    }
    
    @IBAction func onClickUploadImage(_ sender: UIButton) {
        if imageData == nil || (uploadImageTokenTf.text ?? "").isEmpty {
            self.imageUploadLogView.text = "Image is not loaded OR Token is Empty"
        }
        
        EroojaAPIRequest().requestUploadImage(imageData: imageData!, token: uploadImageTokenTf.text!, completion: { result in
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
                    
                    self.imageUploadLogView.text = debugLogText
                } catch {
                    var debugLogText = ""
                    let message: String = (responseValue["message"] as? String) ?? ""
                    debugLogText += "\(responseValue["status"])\n"
                    debugLogText += "\(message.removingPercentEncoding)\n"
                    debugLogText += "JSON Decode Error"
                    self.imageUploadLogView.text = debugLogText
                }
            case .failure(let error):
                self.imageUploadLogView.text = error.localizedDescription
            }
        })
    }
    
    fileprivate func showLoadImageAlertView() {
        let alert   =  UIAlertController(title: "사진 불러오기", message: "원하는 항목을 선택하세요", preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary() }
        let camera  =  UIAlertAction(title: "카메라", style: .default) { (action) in self.openCamera() }
        let cancel  = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func openLibrary() {
        picker.sourceType = .photoLibrary
        present(picker, animated: false, completion: nil)
    }
    
    private func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
        } else {
            ELog.debug("Camera not available")
        }
    }
}

extension UserAPIViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage, let imgData = image.jpegData(compressionQuality: 0.2) {
            ELog.debug("Image Load Finished")
            var debugLog = "Image Load Finished\n"
            debugLog += "Image URL : \(info[UIImagePickerController.InfoKey.imageURL])"
            imageUploadLogView.text = debugLog
            lblImageFileName.text = "\(info[UIImagePickerController.InfoKey.imageURL])"
            self.imageData = imgData
        } else {
            imageUploadLogView.text = "Image Load Error"
        }
        
        dismiss(animated: true, completion: nil)
    }
    
//    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        if let _ = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage{
//            //                imageView.image = image
//            ELog.debug(info)
//        }
//        dismiss(animated: true, completion: nil)
//    }
}
