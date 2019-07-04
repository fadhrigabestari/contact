//
//  Contact.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 04/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation

struct Contact: Codable {
    var id: Int
    var firstName: String
    var lastName: String
    var profilePic: URL
    var isFavourite: Bool
    var url: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case profilePic = "profile_pic"
        case isFavourite = "favourite"
        case url
    }
}
