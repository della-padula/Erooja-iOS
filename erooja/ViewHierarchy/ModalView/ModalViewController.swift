//
//  ModalView.swift
//  erooja
//
//  Created by 김태인 on 2020/04/03.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaUI
import EroojaCommon

public class ModalViewController: BaseViewController {
    private var imageButton = EButton()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setViewLayout()
    }
    
    private func setViewLayout() {
        imageButton.image = .back_button
        imageButton.backgroundColor = .green
        self.view.addSubview(imageButton)
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        imageButton.heightAnchor.constraint(equalToConstant: 44).isActive = false
        imageButton.widthAnchor.constraint(equalTo: imageButton.heightAnchor, multiplier: 1.0).isActive = true
        imageButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    }
}
