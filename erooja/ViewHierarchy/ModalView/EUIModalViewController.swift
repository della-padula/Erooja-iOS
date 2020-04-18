//
//  ModalView.swift
//  erooja
//
//  Created by 김태인 on 2020/04/03.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaUI
import EroojaCommon

public enum ModalType {
    case flag
    case goal
    case flagWithHands
}

public protocol EUIModalViewDelegate {
    func modalViewController() -> (String, String, String, ModalType)
    
    func onClickBottomButton()
}

public class EUIModalViewController: BaseViewController {
    private var imageButton = EButton()
    private var bottomButton = EButton()
    
    private var imageBackgroundView = UIImageView()
    private var imageForegroundLogoGoal = UIImageView()
    private var imageForegroundLogoFlag = UIImageView()
    private var imageForegroundLogoFlagWithHands = UIImageView()
    
    private var modalTitleLabel = UILabel()
    private var modalContentLabel = UILabel()
    
    private var imageForegroundLogoTopAnchor: NSLayoutConstraint?
    private var imageForegroundLogoHeightAnchor: NSLayoutConstraint?
    
    public var delegate: EUIModalViewDelegate?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.setViewLayout()
        self.getDataFromDelegate(data: delegate?.modalViewController())
    }
    
    private func getDataFromDelegate(data: (String, String, String, ModalType)?) {
        guard let data = data else { return }
        
        self.modalTitleLabel.text = data.0
        self.modalContentLabel.text = data.1
        
        self.bottomButton.title = data.2
        
        // Set Type to Logo View
        switch data.3 {
        case .flag:
            setLogoImageHidden(isHiddenFlag: false, isHiddenGoal: true, isHiddenFlagWithHands: true)
        case .goal:
            setLogoImageHidden(isHiddenFlag: true, isHiddenGoal: false, isHiddenFlagWithHands: true)
        case .flagWithHands:
            setLogoImageHidden(isHiddenFlag: true, isHiddenGoal: true, isHiddenFlagWithHands: false)
        }
    }
    
    private func setViewLayout() {
        imageButton.image = .commonIcoClose
        imageButton.padding = 10
        
        modalTitleLabel.font = .SpoqaBold20P
        modalContentLabel.font = .SpoqaRegular14P
        modalTitleLabel.textColor = EroojaColorSet.shared.gray700
        modalContentLabel.textColor = EroojaColorSet.shared.gray500
        
        modalTitleLabel.numberOfLines = 0
        modalTitleLabel.textAlignment = .center
        modalContentLabel.numberOfLines = 0
        modalContentLabel.textAlignment = .center
        
        bottomButton.font = .SpoqaRegular15P
        bottomButton.textColor = .white
        bottomButton.layer.cornerRadius = 4
        bottomButton.backgroundColor = EroojaColorSet.shared.orgDefault400
        
        imageButton.addTarget(target: self, action: #selector(onClickCloseButton), forEvent: .touchUpInside)
        bottomButton.addTarget(target: self, action: #selector(onClickBottomButton), forEvent: .touchUpInside)
        
        imageBackgroundView.image = .modalBackground
        imageBackgroundView.contentMode = .scaleToFill
        
        imageForegroundLogoGoal.image = .modelLogoGoal
        imageForegroundLogoGoal.contentMode = .scaleAspectFit
        imageForegroundLogoFlag.image = .modelLogoGoalFlag
        imageForegroundLogoFlag.contentMode = .scaleAspectFit
        imageForegroundLogoFlagWithHands.image = .modelLogoGoalFlagHand
        imageForegroundLogoFlagWithHands.contentMode = .scaleAspectFit
        
        self.view.addSubview(imageButton)
        self.view.addSubview(bottomButton)
        self.view.addSubview(imageBackgroundView)
        self.view.bringSubviewToFront(imageButton)
        
        self.view.addSubview(modalTitleLabel)
        self.view.addSubview(modalContentLabel)
        
        self.view.addSubview(imageForegroundLogoGoal)
        self.view.addSubview(imageForegroundLogoFlag)
        self.view.addSubview(imageForegroundLogoFlagWithHands)
        
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        modalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        modalContentLabel.translatesAutoresizingMaskIntoConstraints = false
        imageBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        imageForegroundLogoGoal.translatesAutoresizingMaskIntoConstraints = false
        imageForegroundLogoFlag.translatesAutoresizingMaskIntoConstraints = false
        imageForegroundLogoFlagWithHands.translatesAutoresizingMaskIntoConstraints = false
        
        imageButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        imageButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageButton.widthAnchor.constraint(equalTo: imageButton.heightAnchor, multiplier: 1.0).isActive = true
        
        imageBackgroundView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageBackgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageBackgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        imageBackgroundView.heightAnchor.constraint(equalTo: imageBackgroundView.widthAnchor, multiplier: 306/360).isActive = true

        imageForegroundLogoGoal.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageForegroundLogoGoal.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6).isActive = true
        imageForegroundLogoGoal.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120).isActive = true
        imageForegroundLogoGoal.heightAnchor.constraint(equalTo: imageForegroundLogoGoal.widthAnchor, multiplier: 230/211).isActive = true
        
        imageForegroundLogoFlag.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageForegroundLogoFlag.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        imageForegroundLogoFlag.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 132).isActive = true
        imageForegroundLogoFlag.heightAnchor.constraint(equalTo: imageForegroundLogoGoal.widthAnchor).isActive = true
        
        imageForegroundLogoFlagWithHands.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageForegroundLogoFlagWithHands.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        imageForegroundLogoFlagWithHands.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        imageForegroundLogoFlagWithHands.heightAnchor.constraint(equalTo: imageForegroundLogoGoal.widthAnchor, multiplier: 227/160).isActive = true
        
        modalTitleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        modalTitleLabel.topAnchor.constraint(equalTo: imageBackgroundView.bottomAnchor, constant: 70).isActive = true
        modalContentLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        modalContentLabel.topAnchor.constraint(equalTo: modalTitleLabel.bottomAnchor, constant: 10).isActive = true
        
        bottomButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        bottomButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        bottomButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        bottomButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        bottomButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    @objc
    public func onClickCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    public func onClickBottomButton() {
        self.delegate?.onClickBottomButton()
    }
    
    fileprivate func setLogoImageHidden(isHiddenFlag: Bool, isHiddenGoal: Bool, isHiddenFlagWithHands: Bool) {
        imageForegroundLogoGoal.isHidden = isHiddenGoal
        imageForegroundLogoFlag.isHidden = isHiddenFlag
        imageForegroundLogoFlagWithHands.isHidden = isHiddenFlagWithHands
        
        imageBackgroundView.isHidden = !isHiddenGoal
    }
}
