//
//  APITestViewModel.swift
//  erooja
//
//  Created by Denny on 2020/05/01.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import Promises
import EroojaCommon

public enum EroojaAPIType: String, CaseIterable {
    case TokenAPI  = "Access Token API"
    case memberAPI = "User API"
    case jobInterestAPI = "Job Interest API"
    case goalAPI   = "Goal API"
    case goalAndUserAPI = "Goal And User API"
}

public struct APITestViewModel {
    
    enum FetchError: LocalizedError {
        case noData
    }
    
    var apiTestItems = DataBinding([EroojaAPIType]())
    
    func setAPIItemsToView() {
        ELog.debug("ViewModel : setDevAPITestItemsToView")
        fetchMenuItems().then { list in
            self.apiTestItems.valueForBind = list
        }
    }
    
    private func fetchMenuItems() -> Promise<[EroojaAPIType]> {
        return Promise<[EroojaAPIType]> { fulfill, reject in
            let list = EroojaAPIType.allCases
            if list.count > 0 {
                fulfill(list)
            } else {
                reject(FetchError.noData)
            }
        }
    }
}
