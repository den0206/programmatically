//
//  NewMessagesController.swift
//  programmatically
//
//  Created by 酒井ゆうき on 2020/04/11.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
private let reuseIdentifer = "UserCell"

class NewMessagesController : UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
    }
    
    private func configureUI() {
        configureNav(title: "New Message", preferLargeTitle: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismiss))
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 80
        
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifer)
    }
    
    
    private func configureNav() {
        
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.largeTitleTextAttributes = [.foregroundColor : UIColor.white]
        appearence.backgroundColor = .green
        
        
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Message"
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
    }
    
    //MARK: - Actions
    
    @objc func handleDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension NewMessagesController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! UserCell
        cell.textLabel?.text = "Test"
        return cell
    }
}
