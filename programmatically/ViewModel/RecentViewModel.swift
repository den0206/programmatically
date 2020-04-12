//
//  RecentViewModel.swift
//  programmatically
//
//  Created by 酒井ゆうき on 2020/04/12.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation

struct RecentViewModel {
    private let recent : Recent
    
    var username : String {
        return recent.user.username
    }
    
    var lastMessage : String {
        return recent.message.text
    }
    
    var profileImageUrl : URL? {
      return URL(string: recent.user.profileImage)
    }
    
    var timeStamp : String {
        
        /// firestroe Timestamp DateFormatter
        let date = recent.message.timeStamp.dateValue()
        let datefomatter = DateFormatter()
        datefomatter.dateFormat = "hh:mm a"
        
        return datefomatter.string(from: date)
    }
    
    init(recent : Recent) {
        
        self.recent = recent
    }
}
