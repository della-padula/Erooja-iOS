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
        
        bindViewModel()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        
        loadMenuItems()
    }
    
    func bindViewModel() {
        if let viewModel = viewModel {
            viewModel.menuItems.bind({ (menuItems) in
                DispatchQueue.main.async {
                    ELog.debug(message: "Menu Items : \(menuItems)")
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
        switch type {
        case .signup:
            let vc = SignUpViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        case .onboard:
            let vc = OnboardViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        case .search:
            let vc = SearchViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        case .modalViewTest:
            let vc = ModalViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        default:
            break
        }
    }
    
}

