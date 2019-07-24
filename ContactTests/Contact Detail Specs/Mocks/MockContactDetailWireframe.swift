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


class MockContactDetailWireframe: IContactDetailWireframe {
    var presenter: IContactDetailPresenter?
    var pushToMessageScreenCounter = 0
    var pushToCallScreenCounter = 0
    var pushToEmailScreenCounter = 0
    var pushToEditScreenCounter = 0
    
    func createModule() -> ContactDetailViewController {
        return ContactDetailViewController()
    }
    
    func pushToMessageScreen(number: String) {
        pushToMessageScreenCounter += 1
    }
    
    func pushToCallScreen(number: String) {
        pushToCallScreenCounter += 1
    }
    
    func pushToEmailScreen(email: String) {
        pushToEmailScreenCounter += 1
    }
    
    func pushToEditScreen(navigationController: UINavigationController, contact: ContactDetailEntity) {
        pushToEditScreenCounter += 1
    }
}
