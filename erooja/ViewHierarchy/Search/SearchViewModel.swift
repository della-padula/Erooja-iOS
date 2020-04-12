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
    var stringList = DataBinding([String]())
    var resultList = DataBinding([PortfolioModel]())
}

extension SearchViewModel {
    func setSearchKeyworld(keyword: String) {
        searchKeyword.valueForBind = keyword
    }
    
    func fetchDataForSearch(keyword: String) {
        
    }
    
    func removeAllStringList() {
        stringList.valueForBind.removeAll()
    }
    
    func setStringListBasedKeyword(keyword: String) {
        stringList.valueForBind.removeAll()
        
        for index in 0..<5 {
            stringList.valueForBind.append("\(keyword) - \(index)")
        }
    }
}
