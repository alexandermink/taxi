//
//  ProfileTableViewManager.swift
//  finch-taxi-aleksandr
//
//  Created Александр Минк on 16.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

import UIKit

protocol ProfileTableViewManagerDelegate: AnyObject {
    func didSelectItem(by index: Int)
}

protocol ProfileTableViewManagerInput {
    func setup(tableView: UITableView)
    func update(with viewModel: ProfileViewModel)
}

final class ProfileTableViewManager: NSObject {
    
    // MARK: - Properties
    
    weak var delegate: ProfileTableViewManagerDelegate?
    
    private weak var tableView: UITableView?
    
    private var viewModel: ProfileViewModel?
    
}


// MARK: - ProfileTableViewManagerInput
extension ProfileTableViewManager: ProfileTableViewManagerInput {
    
    func setup(tableView: UITableView) {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileInfoTableViewCell.self, CustomTableViewCell.self)
        self.tableView = tableView
    }
    
    func update(with viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        tableView?.reloadData()
    }
    
}


// MARK: - UITableViewDataSource
extension ProfileTableViewManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let row = viewModel?.rows[indexPath.row] else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: row.id, for: indexPath)
        row.configurator.configure(cell)
        return cell
    }
    
}


// MARK: - UITableViewDelegate
extension ProfileTableViewManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        viewModel?.rows[indexPath.row].configurator.cellHeight ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(by: indexPath.row)
    }
}
