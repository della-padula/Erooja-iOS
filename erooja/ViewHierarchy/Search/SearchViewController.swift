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
    
    public var viewModel: SearchViewModel?
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
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
}
