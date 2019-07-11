//
//  ContactDetailView.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 08/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation

typealias RowItemContactDetail = (category: String, value: String)

struct ContactDetailEntity {
    var firstName: String
    var lastName: String
    var profilePic: String
    var phoneNumber: String
    var email: String
    var isFavorite: Bool
    var rows: [RowItemContactDetail]
}
