//
//  SignupViewModel.swift
//  programmatically
//
//  Created by 酒井ゆうき on 2020/04/10.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Foundation

struct SignupViewModel : AuthentificationProtocol {
    var email : String?
    var password : String?
    var fullname : String?
    var username : String?
    
    var formIsValid : Bool {
        return email?.isEmpty == false
            && password?.isEmpty == false
            && fullname?.isEmpty == false
            && username?.isEmpty == false
    }
}
