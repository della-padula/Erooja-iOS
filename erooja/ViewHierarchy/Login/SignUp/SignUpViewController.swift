//
//  SignUpViewController.swift
//  erooja
//
//  Created by 김태인 on 2020/04/01.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaCommon
import EroojaUI
import UIKit

public protocol SignUpCellDelegate {
    func nicknameValidation(isButtonActive: Bool, nickname: String?)
}

public class SignUpViewController: BaseViewController {
    private var collectionPageView: UICollectionView?
    private var navigationView = UIView()
    private var backButton = UIButton()
    private var bottomButton = UIButton()
    
    private let viewModels: [SignUpViewModel] = [SignUpViewModel(title: "닉네임을 입력하세요.", type: .nickname), SignUpViewModel(title: "관심있는 직군을 골라주세요.", type: .field), SignUpViewModel(title: "직무도 함께 골라주세요.", type: .field)]
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setNavigationBar()
        self.setViewLayout()
        self.setCollectionView()
    }
    
    private func setCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height - 44 - 44)
        
        self.collectionPageView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        self.collectionPageView?.backgroundColor = .clear
        self.collectionPageView?.isPagingEnabled = true
        self.collectionPageView?.isScrollEnabled = false
        self.collectionPageView?.register(SignUpViewCell.self, forCellWithReuseIdentifier: "SignUpViewCell")
        
        view.addSubview(self.collectionPageView!)
        self.collectionPageView!.translatesAutoresizingMaskIntoConstraints = false
        self.collectionPageView!.topAnchor.constraint(equalTo: self.navigationView.bottomAnchor).isActive = true
        self.collectionPageView!.bottomAnchor.constraint(equalTo: self.bottomButton.topAnchor).isActive = true
        self.collectionPageView!.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.collectionPageView!.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.collectionPageView?.delegate = self
        self.collectionPageView?.dataSource = self
    }
    
    private func setNavigationBar() {
//        self.navigationView.backgroundColor = .green
        self.view.addSubview(self.navigationView)
        
        self.navigationView.translatesAutoresizingMaskIntoConstraints = false
        self.navigationView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.navigationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.navigationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.backButton.setImage(UIImage(named: "back_button"), for: .normal)
        self.backButton.backgroundColor = .white
        self.navigationView.addSubview(self.backButton)
        
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        self.backButton.centerYAnchor.constraint(equalTo: self.navigationView.centerYAnchor).isActive = true
        self.backButton.leadingAnchor.constraint(equalTo: self.navigationView.leadingAnchor).isActive = true
        self.backButton.heightAnchor.constraint(equalTo: self.navigationView.heightAnchor).isActive = true
        self.backButton.widthAnchor.constraint(equalTo: self.backButton.heightAnchor).isActive = true
    }
    
    private func setViewLayout() {
        //gray500s
        //gray300s
        bottomButton.setTitle("다음", for: .normal)
        bottomButton.titleLabel?.font = .AppleSDSemiBold15P
        
        bottomButton.backgroundColor = EroojaColorSet.shared.orgDefault400s
        bottomButton.setTitleColor(EroojaColorSet.shared.whiteBg000s, for: .normal)
        
        view.addSubview(bottomButton)
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bottomButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bottomButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
}

extension SignUpViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SignUpViewCell", for: indexPath) as! SignUpViewCell
        cell.viewModel = viewModels[indexPath.row]
        cell.delegate = self
        return cell
    }
    
}

extension SignUpViewController: SignUpCellDelegate {
    public func nicknameValidation(isButtonActive: Bool, nickname: String?) {
        if isButtonActive {
            bottomButton.backgroundColor = EroojaColorSet.shared.orgDefault400s
            bottomButton.setTitleColor(EroojaColorSet.shared.whiteBg000s, for: .normal)
        } else {
            bottomButton.backgroundColor = EroojaColorSet.shared.gray500s
            bottomButton.setTitleColor(EroojaColorSet.shared.gray300s, for: .normal)
        }
    }
}
