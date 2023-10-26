//
//  User.swift
//  weatherAPP
//
//  Created by Миржигит Суранбаев on 25/10/23.
//

import Foundation
import Firebase

struct User{
    
    let uid: String
    let email: String
    
    init(user: Firebase.User) {
        self.uid = user.uid
        self.email = user.email!
    }
    
}
