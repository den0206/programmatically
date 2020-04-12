//
//  Convesations.swift
//  programmatically
//
//  Created by 酒井ゆうき on 2020/04/07.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import Firebase


private let reuseIdentifer = "Cell"

class ConvesationsController : UIViewController {
    
    private let tableView = UITableView()
    
    private var recents = [Recent]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let actionButton : UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setDimensions(height: 56, width: 56)
        button.layer.cornerRadius = 56 / 2
        button.addTarget(self, action: #selector(handleNewChat), for: .touchUpInside)
        return button
    }()
    
    //MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authenticateUser()
        
        
    }
    
    //MARK: - UI
    
    private func configureUI() {
        
        view.backgroundColor = .white
        
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile(_ :)))
        
        view.addSubview(actionButton)
        actionButton.anchor(bottom : view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,paddingBottom: 16, paddingRight: 24)
        
        
    }
    
    private func convfigureTableview() {
        tableView.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifer)
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
    
    //MARK: - Actions
    
    @objc func showProfile(_ sender : UIBarButtonItem) {
        
       logOut()
    }
    
    @objc func handleNewChat() {
        let newVC = NewMessagesController()
        newVC.delegate = self
        
        let nav = UINavigationController(rootViewController: newVC)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    //MARK: - API
    
    func authenticateUser() {
        
        if Auth.auth().currentUser == nil {
            
            DispatchQueue.main.async {
                let loginVC = LoginController()
                let nav = UINavigationController(rootViewController: loginVC)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }

        } else {
            configureNav(title: "Message", preferLargeTitle: true)
            convfigureTableview()
            configureUI()
            
            fetchRecent()

        }
    }
    
    private func fetchRecent() {
        Service.fetchRecent { (recents) in
            self.recents = recents
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            
            DispatchQueue.main.async {
                let loginVC = LoginController()
                let nav = UINavigationController(rootViewController: loginVC)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } catch {
            print("Can7T signout")
        }
    }
    
}

extension ConvesationsController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath)
        
        cell.detailTextLabel?.text = "Test"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let chatVC = ChatController(user: recents[indexPath.item].user)
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    
}

extension ConvesationsController : NewMessagesControllerDelegate {
    func controller(_ controller: NewMessagesController, withUser user: User) {
        
        controller.dismiss(animated: true, completion: nil)
        
        let chatVC = ChatController(user: user)
        navigationController?.pushViewController(chatVC, animated: true)
        
    }
    
    
}
