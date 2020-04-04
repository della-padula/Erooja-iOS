//
//  DataBinding.swift
//  erooja
//
//  Created by 김태인 on 2020/04/03.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation

public class DataBinding<T> {
//    typealias Listener = (T) -> Void
    var listener: ((T) -> Void)?
    
    func bind(_ listener: ((T) -> Void)?) {
        self.listener = listener
    }
    
    // Bind 하고 초기 값을 바로 바인딩하여 적용하고 싶을 경우
    func bindAndFire(_ listener: ((T) -> Void)?) {
        self.listener = listener
        listener?(valueForBind)
    }
    
    var valueForBind: T {
        didSet {
            listener?(valueForBind)
        }
    }
    
    init(_ value: T) {
        valueForBind = value
    }
}
