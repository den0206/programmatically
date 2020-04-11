//
//  User.swift
//  programmatically
//
//  Created by 酒井ゆうき on 2020/04/11.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation

struct User {
    let uid : String
    let profileImage : String
    let username : String
    let fullname : String
    let email : String
    
    init(dictionary : [String : Any]) {
        
        self.uid = dictionary[kUID] as? String ?? ""
        self.email = dictionary[kEMAIL] as? String ?? ""
        self.fullname = dictionary[kFULLNAME] as? String ?? ""
        self.username = dictionary[kUSERNAME] as? String ?? ""
        self.profileImage = dictionary[kAVATAR] as? String ?? ""


    }
    
}
