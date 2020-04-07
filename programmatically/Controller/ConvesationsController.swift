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
        
       configureUI()
        
    }
    
    private func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Message"
        
        view.backgroundColor = .white
        
        let image = UIImage(systemName: "person.circle.fill")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showProfile(_ :)))
        
    }
    
    //MARK: - Actions
    
    @objc func showProfile(_ sender : UIBarButtonItem) {
        
        print("Show profile")
    }
    
}
