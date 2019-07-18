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
    var email: String?
    var profilePic: String
    var phoneNumber: String?
    var isFavorite: Bool
    var url: String?
    var createdAt: Date?
    var updatedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case profilePic = "profile_pic"
        case phoneNumber = "phone_number"
        case isFavorite = "favorite"
        case url
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    var toContactEntity: ContactEntity {
        return ContactEntity(id: self.id,
                            name: "\(self.firstName) + \(self.lastName)",
                            profilePic: self.profilePic,
                            isFavorite: self.isFavorite)
    }
}
