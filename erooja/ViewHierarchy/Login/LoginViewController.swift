//
//  LoginViewController.swift
//  erooja
//
//  Created by 김태인 on 2020/04/01.
//  Copyright © 2020 김태인. All rights reserved.
//

import UIKit
import EroojaUI
import EroojaNetwork
import EroojaCommon

public class LoginViewController: UIViewController {
    
    private var logoView = UIImageView(image: .mainLogo)
    private var loginButtons = [LoginButton]()
    
    private var guestButton = LoginButton()
    private var kakaoButton = LoginButton()
    private var appleButton = LoginButton()
    private var naverButton = LoginButton()
    private var googleButton = LoginButton()
    
    // 음수로 지정해야 위로 올라옴
    private let loginButtonBottomAnchorConstraint: CGFloat = -24
    private let loginButtonVerticalSpacingContraint: CGFloat = 10
    private let loginButtonHeightConstraint: CGFloat = 52
    private let logoViewHeightConstraint: CGFloat = 48
    
    private var isInitialLoaded = false
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !self.isInitialLoaded {
            self.isInitialLoaded = true
            self.setViewLayout()
        }
    }
    
    private func setViewLayout() {
        loginButtons.append(guestButton)
        view.addSubview(guestButton)
        guestButton.socialType = .guest
        guestButton.translatesAutoresizingMaskIntoConstraints = false
        guestButton.heightAnchor.constraint(equalToConstant: loginButtonHeightConstraint).isActive = true
        guestButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: loginButtonBottomAnchorConstraint).isActive = true
        guestButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        guestButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        // KAKAO BUTTON
        
        loginButtons.append(kakaoButton)
        view.addSubview(kakaoButton)
        kakaoButton.socialType = .kakao
        kakaoButton.setImage(.login_kakao, for: .normal)
        kakaoButton.addTarget(self, action: #selector(onClickKakaoLogin), for: .touchUpInside)
        
        kakaoButton.translatesAutoresizingMaskIntoConstraints = false
        kakaoButton.heightAnchor.constraint(equalToConstant: loginButtonHeightConstraint).isActive = true
        
        // Naver Button 없을 때
        kakaoButton.bottomAnchor.constraint(equalTo: self.guestButton.topAnchor).isActive = true
        kakaoButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        kakaoButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        kakaoButton.imageView?.contentMode = .scaleAspectFit
        kakaoButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
        kakaoButton.imageView?.trailingAnchor.constraint(equalTo: kakaoButton.titleLabel!.leadingAnchor, constant: -10).isActive = true
        kakaoButton.imageView?.widthAnchor.constraint(equalTo: kakaoButton.imageView!.heightAnchor, multiplier: 1).isActive = true
        kakaoButton.imageView?.centerYAnchor.constraint(equalTo: kakaoButton.centerYAnchor).isActive = true
        kakaoButton.imageView?.heightAnchor.constraint(equalTo: kakaoButton.heightAnchor, multiplier: 0.4).isActive = true
        
        self.loadLogoView()
    }
    
    private func loadLogoView() {
        self.view.addSubview(logoView)
        // 187 : 149
        
        let logoViewAreaHeight = view.frame.height - calcButtonHeight() - logoViewHeightConstraint
        
        print(view.frame.height)
        print(logoView.frame.height)
        print(logoViewHeightConstraint)
        print(calcButtonHeight())
        print(logoViewAreaHeight)
        
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: logoViewAreaHeight * (187 / 336)).isActive = true
        logoView.heightAnchor.constraint(equalToConstant: logoViewHeightConstraint).isActive = true
        logoView.widthAnchor.constraint(equalTo: logoView.heightAnchor, multiplier: 55/19).isActive = true
    }
    
    private func calcButtonHeight() -> CGFloat {
        var hasGuest = false
        for loginButton in loginButtons {
            if let type = loginButton.socialType, type == .guest {
                hasGuest = true
                break
            }
        }
        
        return (loginButtonHeightConstraint * CGFloat(loginButtons.count)) + loginButtonBottomAnchorConstraint + loginButtonVerticalSpacingContraint * CGFloat(loginButtons.count - 1) - (hasGuest ? loginButtonVerticalSpacingContraint : 0)
    }
    
    @objc
    private func onClickKakaoLogin() {
        guard let session = KOSession.shared() else {
            return
        }
        
        if session.isOpen() {
            session.close()
        }
        
        session.open { (error) in
            if error != nil || !session.isOpen() { return }
            KOSessionTask.accessTokenInfoTask(completionHandler: { (token, error) in
                ELog.debug("\(String(describing: self)) token        : \(String(describing: token.unsafelyUnwrapped))")
                ELog.debug("\(String(describing: self)) token(id)    : \(String(describing: token?.id))")
                ELog.debug("\(String(describing: self)) token(expire): \(String(describing: token?.expiresInMillis))")
            })
            
            KOSessionTask.userMeTask(completion: { (error, user) in
                ELog.debug("\(String(describing: self)) id          : \(String(describing: user?.id))")
                ELog.debug("\(String(describing: self)) email       : \(String(describing: user?.account?.email))")
                ELog.debug("\(String(describing: self)) birthday    : \(String(describing: user?.account?.birthday))")
                ELog.debug("\(String(describing: self)) birthYear   : \(String(describing: user?.account?.birthyear))")
                ELog.debug("\(String(describing: self)) phoneNumber : \(String(describing: user?.account?.phoneNumber))")
                ELog.debug("\(String(describing: self)) gender      : \(String(describing: user?.account?.gender.rawValue))")
                ELog.debug("\(String(describing: self)) nickname    : \(String(describing: user?.account?.profile?.nickname))")
                
                guard let user = user else { return }
                let request = EroojaAPIRequest()
                request.requestTokenByKakao(id: user.id, accessToken: nil, completion: { result in
                    switch result {
                    case .success(let responseValue):
                        do {
                            let decoder = JSONDecoder()
                            let jsonData = try JSONSerialization.data(withJSONObject: responseValue, options: .prettyPrinted)
                            
                            let tokenInfo = try decoder.decode(TokenModel.self, from: jsonData)
                            ELog.debug("\(String(describing: self)) Token : \(tokenInfo.token)")
                            ELog.debug("\(String(describing: self)) RefreshToken : \(tokenInfo.refreshToken)")
                            ELog.debug("\(String(describing: self)) isAdditionalInfoNeeded : \(tokenInfo.isAdditionalInfoNeeded)")
                            
                            EroojaProperty.accessToken = tokenInfo.token
                            EroojaProperty.refreshToken = tokenInfo.refreshToken
                            EroojaProperty.isAdditionalInfoNeeded = tokenInfo.isAdditionalInfoNeeded
                            EroojaProperty.userId = user.id
                            
                            EroojaProperty.setStoredUserID(userId: user.id!)
                            EroojaProperty.setAccessToken(accessToken: tokenInfo.token)
                            EroojaProperty.setRefreshToken(refreshToken: tokenInfo.refreshToken)
                            
                            let signUpVC = SignUpViewController()
                            signUpVC.modalPresentationStyle = .fullScreen
                            self.present(signUpVC, animated: true, completion: nil)
                            
                        } catch {
                            ELog.error("\(String(describing: self)) JSON Decode Error")
                        }
                    case .failure(let error):
                        ELog.error(error.localizedDescription)
                        ELog.error(error.errorMessage ?? "nil")
                    }
                })
            })
        }
    }
    
}
