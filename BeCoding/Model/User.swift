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
//    var imageLogoUrl = ""
    var imageUrl = ""
//    var title = ""
//    var description = ""
//    var languages = ""
//    var instruction = ""
//    var dataAdd = ""
//    var user = ""
    var email = ""
//    var createdAt:Timestamp?
    
    init(dict:[String:Any]) {
        if let id = dict["id"] as? String,
//            let title = dict["title"] as? String,
      
//         let imageLogoUrl = dict["imageLogoUrl"] as? String,
           let imageUrl = dict["imageUrl"] as? String,
//           let description = dict["description"] as? String,
           let name = dict["name"] as? String,
//           let languages = dict["languages"] as? String,
//           let instruction = dict["instruction"] as? String,
//           let dataAdd = dict["dataAdd"] as? String,
            let email = dict["email"] as? String{
//            let createdAt = dict["createdAt"] as? Timestamp{
//           self.imageUrl = imageUrl
//            self.imageLogoUrl = imageLogoUrl
//            self.title = title
            self.id = id
            self.imageUrl = imageUrl
//            self.description = description
            self.name = name
//            self.languages = languages
//            self.instruction = instruction
//            self.dataAdd = dataAdd
            self.email = email
//            self.createdAt = createdAt
        }
       
       
    }
}


