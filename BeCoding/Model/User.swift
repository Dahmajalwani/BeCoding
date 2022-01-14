//
//  User.swift
//  BeCoding
//
//  Created by dahma alwani on 25/05/1443 AH.
//

import Foundation
import Firebase
struct User {
    var id = ""
    var name = ""
    var imageUrl = ""
    var email = ""
    
    init(dict:[String:Any]) {
        if let id = dict["id"] as? String,
           let imageUrl = dict["imageUrl"] as? String,
           let name = dict["name"] as? String,
            let email = dict["email"] as? String{
            self.id = id
            self.imageUrl = imageUrl
            self.name = name
            self.email = email
        }
    }
}


