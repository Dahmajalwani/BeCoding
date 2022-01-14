//
//  Courses.swift
//  BeCoding
//
//  Created by dahma alwani on 25/05/1443 AH.
//

import Foundation
import Firebase
struct Course {
    var id = ""
    var title = ""
    var imageUrl = ""
    var description = ""
    var language = ""
    var instruction = ""
    var user:User
    var createdAt:Timestamp?
    
    init(dict:[String:Any] ,id:String ,user:User) {
        
        if let imageUrl = dict["imageUrl"] as? String,
           let title = dict["title"] as? String,
           let language = dict["language"] as? String,
           let description = dict["description"] as? String,
           let instruction = dict["instruction"] as? String,
           let createdAt = dict["createdAt"] as? Timestamp{
            self.title = title
            self.imageUrl = imageUrl
            self.description = description
            self.language = language
            self.instruction = instruction
            self.createdAt = createdAt
        }
        self.id = id
        self.user = user
    }
}
