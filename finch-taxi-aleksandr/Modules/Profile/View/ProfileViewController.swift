//
//  ProfileViewController.swift
//  finch-taxi-aleksandr
//
//  Created Александр Минк on 16.02.2022.
//  Copyright © 2022 FINCH. All rights reserved.
//

import UIKit

protocol ProfileViewInput: Alertable {
    func update(with viewModel: ProfileViewModel)
}

final class ProfileViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: ProfileViewOutput?
    var tableViewManager: ProfileTableViewManagerInput?
    
    private let tableView = UITableView()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawSelf()
        presenter?.viewIsReady()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    
    // MARK: - Private Methods
    
    private func drawSelf() {
        
        view.backgroundColor = Colors.whiteBlack
        
        tableView.backgroundColor = Colors.whiteBlack
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        tableViewManager?.setup(tableView: tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


// MARK: - ProfileViewInput
extension ProfileViewController: ProfileViewInput {
    
    func update(with viewModel: ProfileViewModel) {
        tableViewManager?.update(with: viewModel)
    }
    
}
