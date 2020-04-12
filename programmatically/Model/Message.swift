//
//  Message.swift
//  programmatically
//
//  Created by 酒井ゆうき on 2020/04/12.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Firebase

struct Message {
    let text : String
    let told : String
    let fromId : String
    var timeStamp : Timestamp!
    var user : User?
    let isFromCurrentUser : Bool
    
    var chatPartnerId : String {
        return isFromCurrentUser ? told : fromId
    }
    
    init(dictionary : [String :Any]) {
        self.text = dictionary[kTEXT] as? String ?? ""
        self.told = dictionary[kTOLD] as? String ?? ""
        self.fromId = dictionary[kFROMID] as? String ?? ""
        self.timeStamp = dictionary[kTIMESTAMP] as? Timestamp ?? Timestamp(date: Date())
        
        self.isFromCurrentUser = told != Auth.auth().currentUser?.uid
        
        
        
    }
    
}

struct Recent {
    let user : User
    let message : Message
}
