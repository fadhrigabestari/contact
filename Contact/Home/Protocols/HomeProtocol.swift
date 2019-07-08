//
//  HomeProtocol.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 05/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewToPresenterProtocol: class {
    func startFetchingContacts()
    func onAddButtonPressed(navigationController: UINavigationController)
    func onGroupsButtonPressed(navigationController: UINavigationController)
    func onContactsCellPressed(navigationController: UINavigationController)
}

protocol HomePresenterToViewProtocol: class {
    func showContacts(contacts: [Contact])
}

protocol HomePresenterToWireframeProtocol: class {
    func createModule() -> HomeViewController
    func pushToAddScreen(navigationController: UINavigationController)
    func pushToGroupsScreen(navigationController: UINavigationController)
    func pushToContactDetailScreen(navigationController: UINavigationController)
}

protocol HomePresenterToInteractorProtocol: class {
    var presenter: HomeInteractorToPresenterProtocol? {get set}
    
    func fetchContacts()
}

protocol HomeInteractorToPresenterProtocol: class {
    func contactsFetchSuccess(contacts: [Contact])
    func contactsFetchFailed()
}
