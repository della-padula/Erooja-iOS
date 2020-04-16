//
//  UITestViewController.swift
//  erooja
//
//  Created by 김태인 on 2020/03/30.
//  Copyright © 2020 김태인. All rights reserved.
//

import EroojaUI
import EroojaCommon
import EroojaNetwork
import EroojaSharedBase

class UITestViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    public var viewModel: UITestViewModel?
    
    private var types = [EroojaType]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        showAllCustomFonts()
        bindViewModel()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        
        loadMenuItems()
    }
    
    private func showAllCustomFonts() {
        for family: String in UIFont.familyNames
        {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
    }
    
    func bindViewModel() {
        if let viewModel = viewModel {
            viewModel.menuItems.bind({ (menuItems) in
                DispatchQueue.main.async {
                    self.types = menuItems
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    func loadMenuItems() {
        ELog.debug(message: "loadMenuItems")
        viewModel?.setDevMenuItemsToView()
    }

}

extension UITestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EroojaDevCell", for: indexPath) as! UITestTableViewCell
        cell.lblTitle.text = types[indexPath.row].rawValue
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = types[indexPath.row]
        ELog.debug(message: "Selected : \(type.rawValue)")
        
        var vc: UIViewController?
        
        switch type {
        case .signup:
            vc = SignUpViewController()
        case .onboard:
            vc = OnboardViewController()
        case .addGoal:
            let dst = CreateGoalViewController()
            dst.viewModel = CreateGoalViewModel()
            self.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(dst, animated: true)
        case .search:
            let dst = SearchViewController()
            dst.viewModel = SearchViewModel()
            self.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(dst, animated: true)
        case .modalViewTest:
            vc = EUIModalViewController()
        case .dragTable:
//            let dragVC = DraggableTableViewController()
//            dragVC.viewModel = DraggableTableViewModel()
//            dragVC.modalPresentationStyle = .fullScreen
//            present(dragVC, animated: true, completion: nil)
            break
        default:
            break
        }
        if let nextVC = vc {
            nextVC.modalPresentationStyle = .fullScreen
            present(nextVC, animated: true, completion: nil)
        }
    }
    
}

