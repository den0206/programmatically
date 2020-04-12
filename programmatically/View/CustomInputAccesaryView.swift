//
//  CustomInputAccesaryView.swift
//  programmatically
//
//  Created by 酒井ゆうき on 2020/04/11.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

protocol CustomInputAccesaryViewDelegate : class {
    func inputView(_ inputview : CustomInputAccesaryView, message : String)
}

class CustomInputAccesaryView : UIView {
    weak var delegate : CustomInputAccesaryViewDelegate?
    
    //MARK: - parts
    private lazy var messageInputTextView : UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        return tv
    }()
    
    private lazy var sendButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.systemPurple, for: .normal)
        button.setDimensions(height: 50, width: 50)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return button
    }()
    
    private let placeholderLagel : UILabel = {
        let label = UILabel()
        label.text = "Enter Message"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        autoresizingMask = .flexibleHeight
        
        /// shadow
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: -8)
        layer.shadowColor = UIColor.lightGray.cgColor
        
        addSubview(sendButton)
        sendButton.anchor(top : topAnchor,right: rightAnchor,paddingTop: 6,paddingRight: 8)
        
        addSubview(messageInputTextView)
        messageInputTextView.anchor(top : topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor,right: sendButton.leftAnchor,paddingTop: 12,paddingLeft: 4,paddingBottom: 8, paddingRight: 8)
        
        addSubview(placeholderLagel)
        placeholderLagel.anchor(left : messageInputTextView.leftAnchor,paddingLeft: 4)
        placeholderLagel.centerY(inView: messageInputTextView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return . zero
    }
    
    //MARK: - Actions
    @objc func sendMessage() {
        guard let message = messageInputTextView.text else {return}
        delegate?.inputView(self, message: message)
    }
    
    @objc func handleTextInputChange() {
        placeholderLagel.isHidden = !self.messageInputTextView.text.isEmpty
    }
    
    func clearMessageText() {
        messageInputTextView.text = nil
        placeholderLagel.isHidden = false
    }
}
