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
    
        firebaseReference(.User).getDocuments { (snapshot, error) in
            
            guard let snapshot = snapshot else {return}
            
            var users = snapshot.documents.map({ User(dictionary: $0.data())})
            
            /// remove current user
            if let i = users.firstIndex(where: {$0.uid == Auth.auth().currentUser?.uid}) {
                users.remove(at: i)
            }
            completion(users)
            
//            if !snapshot.isEmpty {
//                snapshot.documents.forEach { (documet) in
//
//                    let dictionary  = documet.data()
//                    let user = User(dictionary: dictionary)
//
//                    if user.uid != Auth.auth().currentUser?.uid {
//                        users.append(user)
//                    }
//
//                }
//
//                completion(users)
//            }
            
        }
    }
    
    static func fetchUser(userId : String, completion :  @escaping(User) -> Void) {
        
        firebaseReference(.User).document(userId).getDocument { (snapshot, error) in
            
            guard let snapshot = snapshot else {return}
            
            if snapshot.exists {
                let dic = snapshot.data()
                let user = User(dictionary: dic!)
                
                completion(user)
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
            
            /// Recent
            firebaseReference(.Message).document(currentUID).collection(Reference.Recent.rawValue).document(user.uid).setData(values)
            firebaseReference(.Message).document(user.uid).collection(Reference.Recent.rawValue).document(currentUID).setData(values)

            
            
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
    
    static func fetchRecent(completion :  @escaping([Recent]) -> Void) {
        
       
        guard let currentUID = Auth.auth().currentUser?.uid else {return}
        
        let query = firebaseReference(.Message).document(currentUID).collection(Reference.Recent.rawValue).order(by: kTIMESTAMP)
        
        query.addSnapshotListener { (snapshot, error) in
            
            var recents = [Recent]()
            
            guard let snapshot = snapshot else {return}
            
            snapshot.documents.forEach { (document) in
                
                let dic = document.data()
                let message = Message(dictionary: dic)
                
                Service.fetchUser(userId: message.chatPartnerId) { (user) in
                    let recent = Recent(user: user, message: message)
                    recents.append(recent)
                    completion(recents)
                }
                
                
            }
            
//            snapshot.documentChanges.forEach { (diff) in
//
//                if diff.type == .added {
//
//                    let dic = diff.document.data()
//                    let message = Message(dictionary: dic)
//
//                    Service.fetchUser(userId: message.told) { (user) in
//                        let recent = Recent(user: user, message: message)
//                        recents.append(recent)
//                        completion(recents)
//                    }
//
//                }
//
//                if diff.type == .modified {
//                    /// upload lastMessae
//                    let dic = diff.document.data()
//                    let message = Message(dictionary: dic)
//
//                    Service.fetchUser(userId: message.told) { (user) in
//                        let recent = Recent(user: user, message: message)
//                        recents.append(recent)
//                        completion(recents)
//                    }
//                }
//            }
        }
    }
}
