//
//  MockContactDetailWireframe.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 24/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit
@testable import Contact

class MockEditContactDetailWireframe: IEditContactDetailWireframe {
    func createModule(contactDetailDelegate: ContactDetailDelegate) -> EditContactDetailViewController {
        return EditContactDetailViewController()
    }
    
    var isPoppedToContactDetailScreen = false
    func popToContactDetailScreen(navigationController: UINavigationController, contact: Contact) {
        self.isPoppedToContactDetailScreen = true
    }
    
    var isCancelledToContactDetailScreen = false
    func cancelToContactDetailScreen(navigationController: UINavigationController) {
        self.isCancelledToContactDetailScreen = true
    }
}
