//
//  EditContactDetailHeaderEntity.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 11/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation

typealias RowItemEditContactDetail = (category: String, value: String, placeholder: String)

struct EditContactDetailEntity {
    var id: Int
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var profilePic: String
    var isFavorite: Bool
    var createdAt: Date
    var updatedAt: Date
    
    var rows: [RowItemEditContactDetail]
}

extension EditContactDetailEntity {
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
