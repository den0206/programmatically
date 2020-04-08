//
//  Convesations.swift
//  programmatically
//
//  Created by 酒井ゆうき on 2020/04/07.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

private let reuseIdentifer = "Cell"

class ConvesationsController : UIViewController {
    
    private let tableView = UITableView()
    
    //MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNav()
        convfigureTableview()
        configureUI()
        
        
    }
    
    //MARK: - UI
    
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
    
    private func configureUI() {
        
        view.backgroundColor = .white
        
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile(_ :)))
        
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
        
        print("Show profile")
    }
    
}

extension ConvesationsController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath)
        
        cell.detailTextLabel?.text = "Test"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    
}
