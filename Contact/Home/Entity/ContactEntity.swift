//
//  ContactCell.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 08/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation

struct ContactEntity {
    let id: Int
    let name: String
    let profilePic: String
    let isFavorite: Bool
}

extension ContactEntity: Equatable {
    static func == (lhs: ContactEntity, rhs: ContactEntity) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.profilePic == rhs.profilePic &&
        lhs.isFavorite == rhs.isFavorite
    }
}
