//
//  HomeProtocol.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 05/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit

protocol IHomeView: class {
    func showContacts(contacts: [ContactCollection])
}

protocol IHomePresenter: class {
    var contacts: [Contact] {get set}

    func startFetchingContacts()
    func onAddButtonPressed(navigationController: UINavigationController)
    func onGroupsButtonPressed(navigationController: UINavigationController)
    func onContactsCellPressed(navigationController: UINavigationController, id: Int)
    func contactsFetchSuccess(contacts: [Contact])
    func contactsFetchFailed()
    func filterContacts(contacts: [Contact]) -> [ContactCollection]
}

protocol IHomeInteractor: class {
    var presenter: IHomePresenter? {get set}
    
    func fetchContacts()
}

protocol IHomeWireframe: class {
    func createModule() -> HomeViewController
    func pushToAddScreen(navigationController: UINavigationController)
    func pushToGroupsScreen(navigationController: UINavigationController)
    func pushToContactDetailScreen(navigationController: UINavigationController, id: Int)
}

protocol HomeDelegate: class {
    func onContactAdded(contact: Contact)
}


