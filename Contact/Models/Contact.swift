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
}

extension Contact {
    var toContactEntity: ContactEntity {
        return ContactEntity(id: self.id,
                             name: "\(self.firstName) \(self.lastName)",
            profilePic: self.profilePic,
            isFavorite: self.isFavorite)
    }
    
    var toContactDetailEntity: ContactDetailEntity {
        return ContactDetailEntity(id: self.id,
                                   firstName: self.firstName,
                                   lastName: self.lastName,
                                   email: self.email ?? "",
                                   phoneNumber: self.phoneNumber ?? "",
                                   profilePic: self.profilePic,
                                   isFavorite: self.isFavorite,
                                   createdAt: self.createdAt ?? Date(),
                                   updatedAt: self.updatedAt ?? Date(),
                                   rows: [("mobile", self.phoneNumber ?? ""),
                                          ("email", self.email ?? "")])
    }
    
    var toEditContactDetailEntity: EditContactDetailEntity {
        return EditContactDetailEntity(id: self.id,
                                       firstName: self.firstName,
                                       lastName: self.lastName,
                                       email: self.email ?? "",
                                       phoneNumber: self.phoneNumber ?? "",
                                       profilePic: self.profilePic,
                                       isFavorite: self.isFavorite,
                                       createdAt: self.createdAt ?? Date(),
                                       updatedAt: self.updatedAt ?? Date(),
                                       rows: [("First Name", self.firstName, "John"),
                                              ("Last Name", self.lastName, "Doe"),
                                              ("mobile", self.phoneNumber ?? "", "+1234567890"),
                                              ("email", self.email ?? "", "john.doe@email.com")])
    }
    
    var toAddContactEntity: AddContactEntity {
        return AddContactEntity(id: self.id,
                                firstName: self.firstName,
                                lastName: self.lastName,
                                email: self.email ?? "",
                                phoneNumber: self.phoneNumber ?? "",
                                profilePic: self.profilePic,
                                isFavorite: self.isFavorite,
                                createdAt: self.createdAt ?? Date(),
                                updatedAt: self.updatedAt ?? Date(),
                                rows: [("First Name", self.firstName, "John"),
                                       ("Last Name", self.lastName, "Doe"),
                                       ("mobile", self.phoneNumber ?? "", "+1234567890"),
                                       ("email", self.email ?? "", "john.doe@email.com")])
    }
}
