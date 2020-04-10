 //
//  SidnUp.swift
//  programmatically
//
//  Created by 酒井ゆうき on 2020/04/08.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

 import UIKit
 protocol AuthentificationControllerProtocol {
    func checkFormStatus()
 }


 class SignupController : UIViewController {
    
    var selectedIMage : UIImage?
    private var viewModel = SignupViewModel()
    
    //MARK: - Parts
    
    private let plusPhotoButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.setDimensions(height: 200, width: 200)
        button.addTarget(self, action: #selector(handlePlusButton), for: .touchUpInside)
        button.tintColor = .white
        button.clipsToBounds = true

        return button
    }()
    
    private lazy var emailContainerView : UIView = {
        let containerView = inputContainerView(image: UIImage(systemName: "envelope"), textField: emailTextField)
        return containerView
    }()
    
    private lazy var emailTextField : UITextField = {
        return makeTextField(withPlaceholder: "Email", isSecureType: false)
    }()
    
    private lazy var fullnameContainerView : UIView = {
        let containerView = inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x").withTintColor(.black), textField: fullnameTextField)
        return containerView
    }()
    
    private lazy var fullnameTextField : UITextField = {
        return makeTextField(withPlaceholder: "fullname", isSecureType: false)
    }()
    
    private lazy var usernameContainerView : UIView = {
        let containerView = inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x").withTintColor(.black), textField: usernameTextField)
        return containerView
    }()
    
    private lazy var usernameTextField : UITextField = {
        return makeTextField(withPlaceholder: "username", isSecureType: false)
    }()
    
    
    
    private lazy var passwordContainerView : UIView = {
        let containerView = inputContainerView(image: UIImage(systemName: "lock"), textField: passwordTextField)
        return containerView
    }()
    
    private lazy var passwordTextField : UITextField = {
        return makeTextField(withPlaceholder: "Password", isSecureType: true)
    }()
    
    private let signUpButton : UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("SignUp", for: .normal)
         button.layer.cornerRadius = 5
         button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
         button.backgroundColor = .systemGreen
         return button
     }()
     
    let alreadyHaveAccountButton : UIButton  = {
        let button = UIButton(type: .system)
        let attributeTitle = NSMutableAttributedString(string: "アカウントを持っている方は？ ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        attributeTitle.append(NSMutableAttributedString(string: "Log in", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16), NSMutableAttributedString.Key.foregroundColor : UIColor.lightGray]))
        
        button.setAttributedTitle(attributeTitle, for: .normal)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
        
    }()
    
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
        configureUI()
        
     }
    
    private func configureUI() {
        configureGradiantLayer()
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.anchor(top : view.safeAreaLayoutGuide.topAnchor,paddingTop: 32)
        
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, fullnameContainerView,usernameContainerView, passwordContainerView, signUpButton])
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        stack.anchor(top : plusPhotoButton.bottomAnchor,left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32,paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom : view.safeAreaLayoutGuide.bottomAnchor,paddingBottom: 12)
        
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullnameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        
    }
    
    func configureNotificationObserver() {
        
    }
    
    //MARK: - Actions
    
    @objc func handlePlusButton() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func handleLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textDidChange(_ sender : UITextField) {
          
        switch sender {
        case emailTextField:
            viewModel.email = sender.text
        case passwordTextField :
            viewModel.password = sender.text
        case usernameTextField :
            viewModel.username = sender.text
        case fullnameTextField :
            viewModel.fullname = sender.text
        default:
            return
        }
        
           checkFormStatus()
       }
    
    
 }
 
 extension SignupController {
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

 extension SignupController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.originalImage] as? UIImage
        plusPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        plusPhotoButton.layer.borderColor = UIColor(white: 1, alpha: 0.7).cgColor
        plusPhotoButton.layer.borderWidth = 3.0
        plusPhotoButton.layer.cornerRadius = 200 / 2
        
        
        dismiss(animated: true, completion: nil)
    }
    
 }
 
 extension SignupController : AuthentificationControllerProtocol {
    
    func checkFormStatus() {
        if viewModel.formIsValid {
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        } else {
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = .systemGreen
        }
    }
    
 }
