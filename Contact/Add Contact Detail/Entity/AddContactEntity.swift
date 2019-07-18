//
//  AddContactEntity.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 18/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation

struct AddContactEntity {
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String
    let profilePic: String
    let isFavorite: Bool
    let createdAt: Date
    let updatedAt: Date
}

extension AddContactEntity {
    var toContactModel: Contact {
        return Contact(id: self.id,
                       firstName: self.firstName,
                       lastName: self.lastName,
                       email: self.email,
                       profilePic: self.profilePic,
                       phoneNumber: self.phoneNumber,
                       isFavorite: self.isFavorite,
                       url: nil,
                       createdAt: self.createdAt,
                       updatedAt: self.updatedAt)
    }
}
