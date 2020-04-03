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
    
    private var navigationBar: EUINavigationBar?
    public var viewModel: SearchViewModel?
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationBar = EUINavigationBar()
        
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
        self.navigationBar?.barOptions = [.backButton, .textField, .rightFirstButton, .rightSecondButton]
        self.view.addSubview(self.navigationBar!)
        self.navigationBar?.delegate = self
        self.navigationBar?.backgroundColor = .green
        self.navigationBar?.translatesAutoresizingMaskIntoConstraints = false
        self.navigationBar?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.navigationBar?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.navigationBar?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
}

extension SearchViewController: EUINavigationBarDelegate {
    public func onClickBackButton() {
        ELog.debug(message: "Back Button Click")
    }
    
    public func onClickRightSectionButton(at index: Int) {
        
    }
    
    
}
