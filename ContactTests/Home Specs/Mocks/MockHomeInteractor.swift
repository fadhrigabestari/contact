//
//  MockHomeInteractor.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 24/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
@testable import Contact

class MockHomeInteractor: IHomeInteractor {
    var presenter: IHomePresenter?
    var fetchContactsCounter = 0
    
    func fetchContacts() {
        self.fetchContactsCounter += 1
    }
}
