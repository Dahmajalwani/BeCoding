//
//  Courses.swift
//  BeCoding
//
//  Created by dahma alwani on 25/05/1443 AH.
//

import Foundation
struct Courses {
    var id = ""
    var imageLogoUrl = ""
    var name = ""
    var description = ""
    var userId = ""
    
    init(dict:[String:Any]) {
        if let id = dict["id"] as? String,
           let imageLogoUrl = dict["imageLogoUrl"] as? String,
           let name = dict["name"] as? String,
           let description = dict["description"] as? String {
            self.name = name
            self.id = id
            self.description = description
            self.imageLogoUrl = imageLogoUrl
        }
    }
}
