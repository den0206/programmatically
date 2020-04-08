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
    
    private lazy var emailContainerView : UIView = {
        let containerView = inputContainerView(image: UIImage(systemName: "envelope"), textField: emailTextField)
        return containerView
    }()
    
    private lazy var emailTextField : UITextField = {
        return makeTextField(withPlaceholder: "Email", isSecureType: false)
    }()

    private lazy var passwordContainerView : UIView = {
        let containerView = inputContainerView(image: UIImage(systemName: "lock"), textField: passwordTextField)
        return containerView
    }()
    
    private lazy var passwordTextField : UITextField = {
         return makeTextField(withPlaceholder: "Password", isSecureType: true)
     }()
    
    private let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .systemGreen
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confgureUI()
        
    }
    
    private func confgureUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        /// backgroung layer
        configureGradiantLayer()
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top : view.safeAreaLayoutGuide.topAnchor,paddingTop: 32)
        iconImage.setDimensions(height: 120, width: 120)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top : iconImage.bottomAnchor,left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32,paddingRight: 32)
        
        
        
        
    }
    
    func configureGradiantLayer() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.green.cgColor, UIColor.white.cgColor]
        gradient.locations = [0.1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
    
    //MARK: - Helpers
    private func inputContainerView(image : UIImage?, textField : UITextField? = nil) -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        
        let iv = UIImageView()
        iv.image = image
        iv.tintColor = .black
         containerView.addSubview(iv)
        
        if let tf = textField {
            iv.centerY(inView: containerView)
            iv.anchor(left : containerView.leftAnchor,paddingLeft: 8)
            iv.setDimensions(height: 28, width: 28)
            
            
            containerView.addSubview(tf)
            tf.centerY(inView: containerView)
            tf.anchor(left : iv.rightAnchor, bottom:  containerView.bottomAnchor, paddingLeft: 16, paddingBottom: 8)
        }
        
        let separate = UIView()
        separate.backgroundColor = .white
        containerView.addSubview(separate)
        separate.anchor(left : containerView.leftAnchor,bottom: containerView.bottomAnchor,right: containerView.rightAnchor,paddingLeft: 8,height: 0.75)
        
        return containerView
    }
    
    private func makeTextField( withPlaceholder : String, isSecureType : Bool) -> UITextField {
        
        let tf = UITextField()
        tf.borderStyle = .none
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.textColor = .black
        tf.keyboardAppearance = .dark
        tf.isSecureTextEntry = isSecureType
        tf.attributedPlaceholder = NSAttributedString(string: withPlaceholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        tf.autocapitalizationType = .none
        
        return tf
    }
    
    
}
