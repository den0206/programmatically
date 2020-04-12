//
//  RecentCell.swift
//  programmatically
//
//  Created by 酒井ゆうき on 2020/04/12.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class RecentCell : UITableViewCell {
    
    var recent : Recent? {
        didSet {
            configire()
        }
    }
    
    //MARK: - Parts
    
    private let profileImageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .darkGray
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimensions(height: 56, width: 56)
        iv.layer.cornerRadius = 56 / 2
        return iv
    }()
    
    private let userNamelabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "username"
        return label
    }()
    
    private let lastMessagelabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "LastMessage"
        return label
    }()
    
    private let timestampLabel : UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 10)
        
        let stack = UIStackView(arrangedSubviews: [userNamelabel, lastMessagelabel])
        stack.axis = .vertical
        stack.spacing = 8
        
        addSubview(stack)
        stack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        
    
        addSubview(timestampLabel)
        timestampLabel.anchor(top : topAnchor, right: rightAnchor,paddingTop: 20,paddingRight: 12)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configire() {
        
        guard let recent = recent else {return}
        let vm = RecentViewModel(recent: recent)
        
        profileImageView.sd_setImage(with: vm.profileImageUrl)
        lastMessagelabel.text = vm.lastMessage
        userNamelabel.text = vm.username
        timestampLabel.text = vm.timeStamp
        
    }
}
