//
//  AddContactContracts.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 18/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit

protocol IAddContactView: class {
    func showSendAddContactSuccess()
    func showSendAddContactFailed()
}

protocol IAddContactPresenter: class {
    func onDoneButtonPressed(navigationController: UINavigationController, contact: AddContactEntity)
    func sendAddContactSuccess(navigationController: UINavigationController, contact: Contact)
    func sendAddContactFailed()
}

protocol IAddContactInteractor: class {
    var presenter: IAddContactPresenter? {get set}
    
    func sendAddContact(navigationController: UINavigationController, contact: Contact)
}

protocol IAddContactWireframe: class {
    func createModule() -> AddContactViewController
    func pushToHomeScreen(navigationController: UINavigationController, contact: Contact)
    func cancelToHomeScreen(navigationController: UINavigationController)
}
