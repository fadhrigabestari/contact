//
//  MockContactDetailInteractor.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 24/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
@testable import Contact

class MockContactDetailInteractor: IContactDetailInteractor {
    var presenter: IContactDetailPresenter?
    var fetchContactDetailCounter = 0
    var sendContactDetailCounter = 0
    
    func fetchContactDetail(id: Int) {
        fetchContactDetailCounter += 1
    }
    
    func sendContactDetail(contact: Contact) {
        sendContactDetailCounter += 1
    }
}
