//
//  LoginController.swift
//  programmatically
//
//  Created by 酒井ゆうき on 2020/04/08.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit
import Firebase


class LoginController : UIViewController {
    
    private var viewModel = LoginViewModel()
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
        button.titleLabel?.textColor = .white
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
   let dontHaveAccountButton : UIButton  = {
       let button = UIButton(type: .system)
       let attributeTitle = NSMutableAttributedString(string: "アカウントを持っていませんか？ ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
       
       attributeTitle.append(NSMutableAttributedString(string: "Sign up", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16), NSMutableAttributedString.Key.foregroundColor : UIColor.lightGray]))
       
       button.setAttributedTitle(attributeTitle, for: .normal)
       button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
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
        
        view.addSubview(dontHaveAccountButton)
        
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom : view.safeAreaLayoutGuide.bottomAnchor,paddingBottom: 12)
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)

    }
    
    func checkFormStatus() {
        if viewModel.formIsValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .systemGreen
        }
    }
    
    //MARK: - Actions
    
    @objc func handleLogin() {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        AuthService.shared.loginUser(email: email, password: password) { (result, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
        

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
    
    //MARK: - Actions
    
    @objc func handleSignUp() {
        
        let signUpVC = SignupController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func textDidChange(_ sender : UITextField) {
       
        switch sender {
        case emailTextField:
            viewModel.email = sender.text
        case passwordTextField :
            viewModel.password = sender.text
        default:
            return
        }
        
        checkFormStatus()
    }
    
    
}
