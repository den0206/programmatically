//
//  LoginController.swift
//  programmatically
//
//  Created by 酒井ゆうき on 2020/04/08.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit


class LoginController : UIViewController {
    
    //MARK: - Parts
    
    private let iconImage : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "bubble.right")
        iv.tintColor = .white
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confgureUI()
        
        view.addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 120).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
    }
    
    private func confgureUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        /// backgroung layer
        configureGradiantLayer()
    }
    
    func configureGradiantLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.green.cgColor, UIColor.white.cgColor]
        gradient.locations = [0.1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
    
}
