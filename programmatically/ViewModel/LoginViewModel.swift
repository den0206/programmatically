//
//  LoginViewModel.swift
//  programmatically
//
//  Created by 酒井ゆうき on 2020/04/09.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation

struct LoginViewModel {
    
    var email : String?
    var password : String?
    
    var formIsValid : Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}
