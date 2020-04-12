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
    
    static func uploadMessage(_ message : String, toUser user: User,  completion : ((Error?) -> Void)?) {
        
        guard let currentUID = Auth.auth().currentUser?.uid else {return}
        
        let values = [kTEXT : message,
                      kFROMID : currentUID,
                      kTOLD : user.uid,
                      kTIMESTAMP : Timestamp(date: Date())] as [String : Any]
        
        firebaseReference(.Message).document(currentUID).collection(user.uid).addDocument(data: values) { (_) in
            firebaseReference(.Message).document(user.uid).collection(currentUID).addDocument(data: values, completion: completion)
        }

    }
    
    static func fetchMessage(forUser user : User, completion :  @escaping([Message]) -> Void) {
        
        var messages = [Message]()
        
        guard let currentUID = Auth.auth().currentUser?.uid else {return}
        
        let query =  firebaseReference(.Message).document(currentUID).collection(user.uid).order(by: kTIMESTAMP)
        
        query.addSnapshotListener { (snapshot, error) in
            
            guard let snapshot = snapshot else {return}
            
            snapshot.documentChanges.forEach { (diff) in
                
                if diff.type == .added {
                    let dic = diff.document.data()
                    messages.append(Message(dictionary: dic))
                }
            }
            
            completion(messages)
        }
    }
}
