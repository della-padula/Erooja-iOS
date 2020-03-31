//
//  UITestViewController.swift
//  erooja
//
//  Created by 김태인 on 2020/03/30.
//  Copyright © 2020 김태인. All rights reserved.
//

import UIKit

class EroojaDevViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    enum EroojaType: String, CaseIterable {
        case onboard      = "온보딩"
        case kakaoLogin   = "카카오 로그인 API"
        case appleLogin   = "Apple 로그인"
        case login        = "서비스 로그인"
        case mypage       = "마이페이지"
        case nowGoal      = "진행중 목표"
        case modifyToDO   = "진행중 목표 - 할 일 수정학기"
        case togetherList = "진행중 목표 - 함께 참여중인 사용자 리스트"
        case peopleGoal   = "다른 사람 목표"
        case addNewGoal   = "새 목표 추가"
    }
    
    private let types = EroojaType.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.tableFooterView = UIView()
    }

}

extension EroojaDevViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EroojaDevCell", for: indexPath) as! EroojaDevTableViewCell
        cell.lblTitle.text = types[indexPath.row].rawValue
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = types[indexPath.row]
        switch type {
        case .onboard:
            let vc = UIStoryboard.onboardViewController()!
            present(vc, animated: true, completion: nil)
        case .appleLogin:
            let vc = UIStoryboard.loginViewController()!
            present(vc, animated: true, completion: nil)
        default:
            break
        }
    }
    
}
