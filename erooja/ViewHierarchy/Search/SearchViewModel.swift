//
//  SearchViewModel.swift
//  erooja
//
//  Created by 김태인 on 2020/04/03.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaCommon

public struct SearchViewModel {
    var searchKeyword = DataBinding("")
    var resultList = DataBinding([PortfolioModel]())
}

extension SearchViewModel {
    func fetchDataForSearch(keyword: String) {
        
    }
}
