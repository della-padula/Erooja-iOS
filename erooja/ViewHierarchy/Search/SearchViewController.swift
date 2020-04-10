//
//  SearchViewController.swift
//  erooja
//
//  Created by 김태인 on 2020/04/03.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaUI
import EroojaCommon
import EroojaNetwork
import EroojaSharedBase

public class SearchViewController: BaseViewController {
    
    private var navigationBar: EUIHeaderView?
    public var viewModel: SearchViewModel?
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        
        self.navigationBar = EUIHeaderView()
        
        self.bindViewModel()
        self.setViewLayout()
    }
    
    @objc
    private func onClickSearch(keyword: String) {
        
    }
    
    private func bindViewModel() {
        if let viewModel = viewModel {
            viewModel.resultList.bind({ (resultList) in
                DispatchQueue.main.async {
                    ELog.debug(message: "Result List Count : \(resultList.count)")
                }
            })
        }
    }
    
    private func setViewLayout() {
        self.navigationBar?.barOptions = [.backButton, .textField, .rightSecondButton]
        self.view.addSubview(self.navigationBar!)
        
        self.navigationBar?.delegate = self
        self.navigationBar?.rightSecondButtonType = .image
        self.navigationBar?.setRightButtonImage(position: .second, image: UIImage.search_button)
        
        self.navigationBar?.backgroundColor = .white
        self.navigationBar?.textFieldPlaceholder = "검색어를 입력해주세요."
        self.navigationBar?.translatesAutoresizingMaskIntoConstraints = false
        self.navigationBar?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.navigationBar?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.navigationBar?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
}

extension SearchViewController: EUINavigationBarDelegate {
    public func onClickRightSectionButton(at position: ERightButton.Position) {
        ELog.debug(message: "Right Button Click : position - \(position)")
    }
    
    public func onClickBackButton() {
        ELog.debug(message: "Back Button Click")
        #if DEBUG
//        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
        #else
        self.navigationController?.popViewController(animated: true)
        #endif
    }
}
