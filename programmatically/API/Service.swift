//
//  Service.swift
//  programmatically
//
//  Created by 酒井ゆうき on 2020/04/11.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import Firebase

struct Service {
    static  func fetchUsers(completion :  @escaping([User]) -> Void) {
        
        var users = [User]()
        firebaseReference(.User).getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else {return}
            
            if !snapshot.isEmpty {
                snapshot.documents.forEach { (documet) in
                    
                    let dictionary  = documet.data()
                    let user = User(dictionary: dictionary)
                    
                    if user.uid != Auth.auth().currentUser?.uid {
                        users.append(user)
                    }
                    
                }
                
                completion(users)
            }
            
        }
    }
}
