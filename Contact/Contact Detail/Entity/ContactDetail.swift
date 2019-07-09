//
//  ContactDetail.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 08/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation

struct ContactDetail: Codable {
    var id: Int
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var profilePic: String
    var isFavorite: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case phoneNumber = "phone_number"
        case profilePic = "profile_pic"
        case isFavorite = "favorite"
    }
}
