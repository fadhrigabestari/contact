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
    weak var homeDelegate: HomeDelegate?
    
    func createModule(homeDelegate: HomeDelegate) -> AddContactViewController {
        let view = AddContactViewController()
        let interactor = AddContactInteractor()
        let presenter = AddContactPresenter(view: view, interactor: interactor, wireframe: self)
        
        view.presenter = presenter
        interactor.presenter = presenter
        self.homeDelegate = homeDelegate
        return view
    }
    
    func popToHomeScreen(navigationController: UINavigationController, contact: Contact) {
        navigationController.popViewController(animated: true)
        homeDelegate?.onContactAdded(contact: contact)
        navigationController.popViewController(animated: true)
    }
    
    func cancelToHomeScreen(navigationController: UINavigationController) {
        navigationController.popViewController(animated: true)
    }
}
