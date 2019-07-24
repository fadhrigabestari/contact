//
//  MockHomePresenter.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 24/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit

@testable import Contact

class MockHomePresenter: IHomePresenter {
    var contacts: [Contact] = []
    var startFetchingContactsCounter = 0
    var onAddButtonPressedCounter = 0
    var onGroupsButtonPressedCounter = 0
    var onContactsCellPressedCounter = 0
    var onContactsFetchSuccessCounter = 0
    var onContactsFetchFailedCounter = 0
    var FilterContactsCounter = 0
    
    func startFetchingContacts() {
        startFetchingContactsCounter += 1
    }
    
    func onAddButtonPressed(navigationController: UINavigationController) {
        onAddButtonPressedCounter += 1
    }
    
    func onGroupsButtonPressed(navigationController: UINavigationController) {
        onGroupsButtonPressedCounter += 1
    }
    
    func onContactsCellPressed(navigationController: UINavigationController, id: Int) {
        onContactsCellPressedCounter += 1
    }
    
    func contactsFetchSuccess(contacts: [Contact]) {
        self.contacts = contacts
        onContactsFetchSuccessCounter += 1
    }
    
    func contactsFetchFailed() {
        onContactsFetchFailedCounter += 1
    }
    
    func filterContacts(contacts: [Contact]) -> [ContactCollection] {
        FilterContactsCounter += 1
        return [ContactCollection(sectionName: "test", contacts: [contacts.first!.toContactEntity])]
    }
}
