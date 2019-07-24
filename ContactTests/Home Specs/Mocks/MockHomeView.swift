//
//  MockHomeView.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 24/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
@testable import Contact

class MockHomeView: IHomeView {
    var showContactsCounter = 0
    
    func showContacts(contacts: [ContactCollection]) {
        self.showContactsCounter += 1
    }
}
