//
//  HomeWireframe.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 05/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit

class HomeWireframe: IHomeWireframe {
    weak var presenter: IHomePresenter?
    
    internal func createModule() -> HomeViewController {
        let view = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let interactor = HomeInteractor()
        let presenter = HomePresenter(view: view, interactor: interactor, wireframe: self)
        
        view.presenter = presenter
        interactor.presenter = presenter
        self.presenter = presenter
        return view
    }
    
    func pushToAddScreen(navigationController: UINavigationController) {
        let addContactWireframe = AddContactWireframe()
        let addModule = addContactWireframe.createModule(homeDelegate: self)
        navigationController.pushViewController(addModule, animated: true)
    }
    
    func pushToGroupsScreen(navigationController: UINavigationController) {
//        let groupsModule = GroupsWireframe.createModule()
//        navigationController.pushViewController(groupsModule, animated: true)
    }
    
    func pushToContactDetailScreen(navigationController: UINavigationController, id: Int) {
        let contactDetailWireframe = ContactDetailWireframe()
        let contactDetailModule = contactDetailWireframe.createModule()
        contactDetailModule.id = id
        navigationController.pushViewController(contactDetailModule, animated: true)
    }
}

extension HomeWireframe: HomeDelegate {
    func onContactAdded(contact: Contact) {
        self.presenter?.contacts.append(contact)
        self.presenter?.contactsFetchSuccess(contacts: self.presenter!.contacts)
    }
}
