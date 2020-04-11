//
//  AuthService.swift
//  programmatically
//
//  Created by 酒井ゆうき on 2020/04/11.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Firebase

struct RegistrationCredentials {
    let email : String
    let username : String
    let fullname : String
    let password : String
    let profileImage : UIImage
}

class AuthService {
    static let shared = AuthService()
    
    func loginUser(email :String, password : String, completion : AuthDataResultCallback?) {
        
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        
    }
    
    func signUpUser(credential : RegistrationCredentials, completion : ((Error?) -> Void)?) {
        
        guard let imageData = credential.profileImage.jpegData(compressionQuality: 0.3) else {return}
        
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "ProfileImage/\(filename)")
        
        ref.putData(imageData, metadata: nil) { (meta, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            ref.downloadURL { (url, error) in
                
                guard let profileImageUrl = url?.absoluteString else {return}
                
                Auth.auth().createUser(withEmail: credential.email, password: credential.password) { (result, error) in
                    
                    if error != nil {
                        print(error!.localizedDescription)
                        return
                    }
                    
                    guard let uid = result?.user.uid else {return}
                    
                    let values = [kEMAIL : credential.email,
                                  kFULLNAME : credential.fullname,
                                  kUSERNAME : credential.username,
                                  kAVATAR : profileImageUrl,
                                  kUID : uid ] as [String : Any]
                    
                    print(values)
                    
                    firebaseReference(.User).document(uid).setData(values, completion: completion)
                    
                }
            }
        }
        
    }
}
