//
//  EditContactDetailWireframe.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 10/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit

class EditContactDetailWireframe: IEditContactDetailWireframe {
    weak var contactDetailDelegate: ContactDetailDelegate?
    
    func createModule(contactDetailDelegate: ContactDetailDelegate) -> EditContactDetailViewController {
        let view = EditContactDetailViewController()
        let interactor = EditContactDetailInteractor()
        let presenter = EditContactDetailPresenter(view: view, interactor: interactor, wireframe: self)
        
        view.presenter = presenter
        interactor.presenter = presenter
        self.contactDetailDelegate = contactDetailDelegate
        
        return view
    }
    
    func popToContactDetailScreen(navigationController: UINavigationController, contact: Contact) {
        contactDetailDelegate?.onContactEditted(contact: contact)
        navigationController.popViewController(animated: true)
    }
    
    func cancelToContactDetailScreen(navigationController: UINavigationController) {
        _ = navigationController.popViewController(animated: true)
    }
}
