//
//  ChatCell.swift
//  programmatically
//
//  Created by 酒井ゆうき on 2020/04/12.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class ChatCell : UICollectionViewCell {
    
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
    
    private let textView : UIView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.text = "Test"
        return tv
    }()
    
    private let bubbleContainer : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(profileImageView)
        profileImageView.anchor(left : leftAnchor,bottom: bottomAnchor,paddingLeft: 8,paddingBottom: -4)
        
        addSubview(bubbleContainer)
        bubbleContainer.layer.cornerRadius = 12
        bubbleContainer.anchor(top : topAnchor, left: profileImageView.rightAnchor,paddingLeft: 12)
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        addSubview(textView)
        textView.anchor(top : bubbleContainer.topAnchor, left:  bubbleContainer.leftAnchor, bottom: bubbleContainer.bottomAnchor, right: bubbleContainer.rightAnchor,paddingTop: 4,paddingLeft: 12,paddingBottom: 4,paddingRight: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
