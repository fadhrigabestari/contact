//
//  ContactDictionary.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 15/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation

struct ContactCollection {
    let sectionName: String
    var contacts: [ContactEntity]
}

extension ContactCollection: Equatable {
    static func == (lhs: ContactCollection, rhs: ContactCollection) -> Bool {
        return lhs.sectionName == rhs.sectionName &&
        lhs.contacts == rhs.contacts
    }
}
