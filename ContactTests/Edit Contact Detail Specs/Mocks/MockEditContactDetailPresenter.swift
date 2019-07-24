//
//  MockEditContactDetailPresenter.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 24/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit
@testable import Contact

class MockEditContactDetailPresenter: IEditContactDetailPresenter {
    var isDoneButtonPressed = false
    func onDoneButtonPressed(navigationController: UINavigationController, contact: EditContactDetailEntity) {
        self.isDoneButtonPressed = true
    }
    
    var isEditPictureButtonPressed = false
    func onEditPictureButtonPressed() {
        self.isEditPictureButtonPressed = true
    }
    
    var isSendEditedContactDetailSuccess = false
    func sendEditedContactDetailSuccess(navigationController: UINavigationController, contact: Contact) {
        self.isSendEditedContactDetailSuccess = true
    }
    
    var isSendEditedContactDetailFailed = false
    func sendEditedContactDetailFailed() {
        self.isSendEditedContactDetailFailed = true
    }
    
    var isCancelButtonPressed = false
    func onCancelButtonPressed(navigationController: UINavigationController) {
        self.isCancelButtonPressed = true
    }
}
