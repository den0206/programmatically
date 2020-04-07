//
//  Convesations.swift
//  programmatically
//
//  Created by 酒井ゆうき on 2020/04/07.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class ConvesationsController : UIViewController {
    
    //MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNav()
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
    
    //MARK: - Actions
    
    @objc func showProfile(_ sender : UIBarButtonItem) {
        
        print("Show profile")
    }
    
}
