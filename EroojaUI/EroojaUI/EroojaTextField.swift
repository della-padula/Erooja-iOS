//
//  EroojaTextField.swift
//  EroojaUI
//
//  Created by 김태인 on 2020/04/02.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import UIKit

public class EroojaTextField: UITextField {

    deinit {
        self.removeTarget(self, action: #selector(self.editingChanged(_:)), for: .editingChanged)
    }

    private var workItem: DispatchWorkItem?
    private var delay: Double = 0
    private var callback: ((String?) -> Void)? = nil

    public func debounce(delay: Double, callback: @escaping ((String?) -> Void)) {
        self.delay = delay
        self.callback = callback
        DispatchQueue.main.async {
            self.callback?(self.text)
        }
        self.addTarget(self, action: #selector(self.editingChanged(_:)), for: .editingChanged)
    }

    @objc private func editingChanged(_ sender: UITextField) {
      self.workItem?.cancel()
      let workItem = DispatchWorkItem(block: { [weak self] in
          self?.callback?(sender.text)
      })
      self.workItem = workItem
      DispatchQueue.main.asyncAfter(deadline: .now() + self.delay, execute: workItem)
    }
}
