//
//  FIrestoreReference.swift
//  programmatically
//
//  Created by 酒井ゆうき on 2020/04/11.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import FirebaseFirestore

enum Reference : String {
    case User
    case Message
    case Recent
}

func firebaseReference(_ reference : Reference) -> CollectionReference {
    return Firestore.firestore().collection(reference.rawValue)
}
