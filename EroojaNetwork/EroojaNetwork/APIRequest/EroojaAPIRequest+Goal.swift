//
//  EroojaAPIRequest+Goal.swift
//  EroojaNetwork
//
//  Created by Denny on 2020/05/02.
//  Copyright © 2020 Denny.K. All rights reserved.
//

import Foundation
import Alamofire
import EroojaCommon

public extension EroojaAPIRequest {
    func requestSearchGoal(searchModel: GoalSearchModel, token: String, completion: @escaping (Result<Bool, EroojaAPIError>) -> Void) {
        let urlString = GoalAPIRequest.RequestType.searchGoal(searchModel.goalFilterBy, searchModel.keyword, searchModel.fromDt,
                                              searchModel.toDt, searchModel.jobInterestIds, searchModel.goalSortBy,
                                              searchModel.direction, searchModel.size, searchModel.page).requestURL
        ELog.debug("urlString : \(urlString)")
    }
}
