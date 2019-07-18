//
//  AddContactWireframe.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 18/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit

class AddContactWireframe: IAddContactWireframe {
    func createModule() -> AddContactViewController {
        let view = AddContactViewController()
        let interactor = AddContactInteractor()
        let wireframe = AddContactWireframe()
        let presenter = AddContactPresenter(view: view, interactor: interactor, wireframe: wireframe)
        
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
    
    func pushToHomeScreen(navigationController: UINavigationController, contact: Contact) {
        navigationController.popViewController(animated: true)
        if let viewController = navigationController.topViewController as? HomeViewController {
            var contacts = viewController.presenter!.contacts
            contacts.append(contact)
            let collection = viewController.presenter!.filterContacts(contacts: contacts)
            viewController.showContacts(contacts: collection)
        }
    }
    
    func cancelToHomeScreen(navigationController: UINavigationController) {
        navigationController.popViewController(animated: true)
    }
}
