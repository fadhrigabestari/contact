//
//  MockAddContactDetailInteractor.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 24/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit
@testable import Contact

class MockAddContactDetailInteractor: IAddContactInteractor {
    var presenter: IAddContactPresenter?
    
    var isAddContactSent = false
    func sendAddContact(navigationController: UINavigationController, contact: Contact) {
        self.isAddContactSent = true
    }
}
