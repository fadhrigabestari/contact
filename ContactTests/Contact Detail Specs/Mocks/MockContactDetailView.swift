//
//  MockContactDetailView.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 24/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
@testable import Contact

class MockContactDetailView: IContactDetailView {
    var showContactDetailCounter = 0
    var showSendContactDetailSuccessCounter = 0
    
    func showContactDetail(contact: ContactDetailEntity) {
        self.showContactDetailCounter += 1
    }
    
    func showSendContactDetailSuccess() {
        self.showSendContactDetailSuccessCounter += 1
    }
}
