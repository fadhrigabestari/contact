//
//  MockAddContactDetailWireframe.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 24/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit
@testable import Contact

class MockAddContactDetailWireframe: IAddContactWireframe {
    func createModule(homeDelegate: HomeDelegate) -> AddContactViewController {
        return AddContactViewController()
    }
    
    var isPoppedToHomeScreen = false
    func popToHomeScreen(navigationController: UINavigationController, contact: Contact) {
        self.isPoppedToHomeScreen = true
    }
    
    var isCancelledToHomeScreen = false
    func cancelToHomeScreen(navigationController: UINavigationController) {
        self.isCancelledToHomeScreen = true
    }
}
