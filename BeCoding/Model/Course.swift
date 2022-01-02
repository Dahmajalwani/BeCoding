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
    var name = ""
    var description = ""
    var userId = ""
    var user:User
    var createdAt:Timestamp?
    
    init(dict:[String:Any] ,id:String ,user:User) {
        
        if let imageUrl = dict["imageUrl"] as? String,
           let title = dict["title"] as? String,
           let name = dict["name"] as? String,
           let description = dict["description"] as? String,
           let createdAt = dict["createdAt"] as? Timestamp{
            self.title = title
            self.name = name
            self.description = description
            self.imageUrl = imageUrl
            self.createdAt = createdAt
        }
        self.id = id
        self.user = user
    }
}
