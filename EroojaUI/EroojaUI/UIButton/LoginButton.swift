//
//  SocialLoginButton.swift
//  EroojaUI
//
//  Created by 김태인 on 2020/04/01.
//  Copyright © 2020 김태인. All rights reserved.
//

import UIKit

public class LoginButton: UIButton {
    public enum SocialType {
        case apple
        case kakao
        case google
        case naver
        case guest
    }
    
    public var socialType: SocialType? {
        didSet {
            setButtonStyle()
        }
    }
    
    private func setButtonStyle() {
        switch socialType {
        case .kakao:
            backgroundColor = EroojaColorSet.shared.kakaoYellow000s
            setTitle("카카오 계정으로 로그인", for: .normal)
            titleLabel?.font = .AppleSDSemiBold17P
            layer.cornerRadius = 4
            setTitleColor(EroojaColorSet.shared.kakaoBrown000s, for: .normal)
        case .guest:
            backgroundColor = .white
            setTitle("게스트로 시작", for: .normal)
            titleLabel?.font = .AppleSDSemiBold17P
            layer.cornerRadius = 4
            setTitleColor(EroojaColorSet.shared.gray300s, for: .normal)
        case .google:
            break
        case .naver:
            backgroundColor = EroojaColorSet.shared.naverGreen000s
            setTitle("네이버 계정으로 로그인", for: .normal)
            titleLabel?.font = .AppleSDSemiBold17P
            layer.cornerRadius = 4
            setTitleColor(.white, for: .normal)
        case .apple:
            break
        default:
            break
        }
    }
    
    public init() {
        super.init(frame: .zero)
    }
    
    public init(socialType: SocialType) {
        super.init(frame: .zero)
        
        self.socialType = socialType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
