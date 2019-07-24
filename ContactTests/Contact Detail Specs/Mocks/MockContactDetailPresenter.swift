//
//  MockContactDetailPresenter.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 24/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit
@testable import Contact

class MockContactDetailPresenter: IContactDetailPresenter {
    var contactDetailFetchSuccessCounter = 0
    var contactDetailFetchFailedCounter = 0
    var sendContactDetailSuccessCounter = 0
    var sendContactDetailFailedCounter = 0
    
    func onMessageButtonPressed(number: String) {}
    
    func onCallButtonPressed(number: String) {}
    
    func onEmailButtonPressed(email: String) {}
    
    func onFavoriteButtonPressed(contact: ContactDetailEntity) {}
    
    func onEditButtonPressed(navigationController: UINavigationController, contact: ContactDetailEntity) {}
    
    func startFetchingContactDetail(id: Int) {}
    
    func contactDetailFetchSuccess(contact: Contact) {
        contactDetailFetchSuccessCounter += 1
    }
    
    func contactDetailFetchFailed() {
        contactDetailFetchFailedCounter += 1
    }
    
    func sendContactDetailSuccess(contact: Contact) {
        sendContactDetailSuccessCounter += 1
    }
    
    func sendContactDetailFailed() {
        sendContactDetailFailedCounter += 1
    }
}
