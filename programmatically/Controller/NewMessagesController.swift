//
//  NewMessagesController.swift
//  programmatically
//
//  Created by 酒井ゆうき on 2020/04/11.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
private let reuseIdentifer = "UserCell"

protocol NewMessagesControllerDelegate : class {
    func controller(_ controller : NewMessagesController, withUser : User)
}

class NewMessagesController : UITableViewController {
    
    weak var delegate : NewMessagesControllerDelegate?
    
    private var users = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchUsers()
        
    }
    
    private func configureUI() {
        configureNav(title: "New Message", preferLargeTitle: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismiss))
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 80
        
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifer)
    }
    
    //MARK: - API
    
    func fetchUsers() {
        Service.fetchUsers { (users) in
            self.users = users
            
        }
    }
    
    
    //MARK: - Actions
    
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension NewMessagesController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! UserCell
        cell.textLabel?.text = "Test"
        
        cell.user = users[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.controller(self, withUser: users[indexPath.row])
    
    }
}
