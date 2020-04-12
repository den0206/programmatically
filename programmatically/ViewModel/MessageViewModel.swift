//
//  MessageViewModel.swift
//  programmatically
//
//  Created by 酒井ゆうき on 2020/04/12.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

struct MessageViewModel {
    
    private let message : Message
    
    var messageBackGroungColor : UIColor {
        return message.isFromCurrentUser ? .green : .lightGray
    }
    
    var messageTextColor : UIColor {
        return message.isFromCurrentUser ? .white : .black
    }
    
    var rightAnchorIsActive :Bool {
        return message.isFromCurrentUser
    }
    
    var leftAnchorIsActive :Bool {
        return !message.isFromCurrentUser
    }
    
    var shouldHideProfileImage : Bool {
        return message.isFromCurrentUser
    }
    
    var profileImageUrl : URL? {
        guard let user = message.user else {return nil}
        return URL(string: user.profileImage)
    }
    
    init(message : Message) {
        self.message = message
    }
}
