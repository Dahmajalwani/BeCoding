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
    var imageLogoUrl = ""
    var title = ""
    var description = ""
    var languages = ""
    var instruction = ""
    var dataAdd = ""
    var createdAt:Timestamp?
    
    init(dict:[String:Any],id:String,user:User) {
        if let imageLogoUrl = dict["imageLogoUrl"] as? String,
           let title = dict["title"] as? String,
           let description = dict["description"] as? String,
           let languages = dict["languages"] as? String,
           let instruction = dict["instruction"] as? String,
           let dataAdd = dict["dataAdd"] as? String,
            let createdAt = dict["createdAt"] as? Timestamp{
            self.imageLogoUrl = imageLogoUrl
            self.title = title
            self.description = description
            self.languages = languages
            self.instruction = instruction
            self.dataAdd = dataAdd
            self.createdAt = createdAt
        }
        self.id = id
       
    }
}


