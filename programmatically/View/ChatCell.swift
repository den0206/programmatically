//
//  ChatCell.swift
//  programmatically
//
//  Created by 酒井ゆうき on 2020/04/12.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class ChatCell : UICollectionViewCell {
    
    var message : Message? {
        didSet {
            configure()
        }
    }
    
    var bubbleLeftAnchor : NSLayoutConstraint!
    var bubbleRightAnchor : NSLayoutConstraint!
    
    //MARK: - Parts
    
    private let profileImageView : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.setDimensions(height: 32, width: 32)
        iv.layer.cornerRadius = 32 / 2
        return iv
    }()
    
    private let textView : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
//        tv.text = "Test"
        return tv
    }()
    
    private let bubbleContainer : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 12

        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.anchor(left : leftAnchor,bottom: bottomAnchor,paddingLeft: 8,paddingBottom: -4)
        
        addSubview(bubbleContainer)
        bubbleContainer.anchor(top : topAnchor, bottom: bottomAnchor)
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        /// set property
        bubbleLeftAnchor = bubbleContainer.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 20)
        bubbleLeftAnchor.isActive = false
        bubbleRightAnchor = bubbleContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
        bubbleRightAnchor.isActive = false
        
        addSubview(textView)
        textView.anchor(top : bubbleContainer.topAnchor, left:  bubbleContainer.leftAnchor, bottom: bubbleContainer.bottomAnchor, right: bubbleContainer.rightAnchor,paddingTop: 4,paddingLeft: 12,paddingBottom: 4,paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        guard let message = message else {return}
        let vm = MessageViewModel(message: message)
        
        textView.text = message.text
        
        bubbleContainer.backgroundColor = vm.messageBackGroungColor
        textView.textColor = vm.messageTextColor
        
        bubbleLeftAnchor.isActive = vm.leftAnchorIsActive
        bubbleRightAnchor.isActive = vm.rightAnchorIsActive
        profileImageView.isHidden = vm.shouldHideProfileImage
        profileImageView.sd_setImage(with: vm.profileImageUrl)
        
        
        
    }
}
