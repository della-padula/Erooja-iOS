//
//  DraggableTableView.swift
//  erooja
//
//  Created by 김태인 on 2020/04/05.
//  Copyright © 2020 김태인. All rights reserved.
//

import Foundation
import EroojaCommon
import EroojaUI

public class DraggableTableViewController: BaseViewController {
    private var imageButton = EButton()
    
    private let tableView = UITableView()
    public var viewModel: DraggableTableViewModel?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.setViewLayout()
        self.bindView()
    }
    
    private func bindView() {
        if let viewModel = viewModel {
            viewModel.tableListItem.bind({ (list) in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
            viewModel.getTableViewData()
        }
    }
    
    private func setViewLayout() {
        imageButton.image = .commonIcoClose
        imageButton.padding = 10
        imageButton.backgroundColor = .white
        imageButton.addTarget(target: self, action: #selector(onClickCloseButton), forEvent: .touchUpInside)
        
        self.view.addSubview(imageButton)
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        imageButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        imageButton.widthAnchor.constraint(equalTo: imageButton.heightAnchor, multiplier: 1.0).isActive = true
        imageButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        tableView.allowsSelectionDuringEditing = true
        tableView.setEditing(true, animated: true)
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.imageButton.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc
    public func onClickCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DraggableTableViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.tableListItem.valueForBind.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel?.tableListItem.valueForBind[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 {
            return false
        } else {
            return true
        }
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ELog.debug(message: "Selected : \(indexPath.row) / \(viewModel?.tableListItem.valueForBind[indexPath.row])")
    }
    
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let stringSource = viewModel?.tableListItem.valueForBind[sourceIndexPath.row] ?? ""
        let stringDest   = viewModel?.tableListItem.valueForBind[destinationIndexPath.row] ?? ""
        viewModel?.tableListItem.valueForBind[destinationIndexPath.row] = stringSource
        viewModel?.tableListItem.valueForBind[sourceIndexPath.row] = stringDest
        
        ELog.debug(message: "source : \(sourceIndexPath.row) dest : \(destinationIndexPath.row)")
    }
    
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    public func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        return proposedDestinationIndexPath
    }
}
