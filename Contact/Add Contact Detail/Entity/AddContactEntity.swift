//
//  AddContactEntity.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 18/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation

typealias RowItemAddContact = (category: String, value: String, placeholder: String)

struct AddContactEntity {
    var id: Int
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var profilePic: String
    var isFavorite: Bool
    var createdAt: Date
    var updatedAt: Date
    
    var rows: [RowItemAddContact]
    
    init() {
        id = 0
        firstName = ""
        lastName = ""
        email = ""
        phoneNumber = ""
        profilePic = ""
        isFavorite = false
        createdAt = Date()
        updatedAt = Date()
        
        rows =  [("First Name", self.firstName, "John"),
                ("Last Name", self.lastName, "Doe"),
                ("mobile", self.phoneNumber, "+1234567890"),
                ("email", self.email, "john.doe@email.com")]
    }
    
    init(id: Int, firstName: String, lastName: String, email: String, phoneNumber: String, profilePic: String, isFavorite: Bool, createdAt: Date, updatedAt: Date, rows: [RowItemAddContact]) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.profilePic = profilePic
        self.isFavorite = isFavorite
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.rows = rows
    }
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
