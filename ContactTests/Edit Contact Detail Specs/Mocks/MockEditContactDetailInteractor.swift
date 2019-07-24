//
//  MockEditContactDetailInteractor.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 24/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit
@testable import Contact

class MockEditContactDetailInteractor: IEditContactDetailInteractor {
    var presenter: IEditContactDetailPresenter?
    var contact: Contact?
    
    func sendEditedContactDetail(navigationController: UINavigationController, contact: Contact) {
        self.contact = contact
    }
}
