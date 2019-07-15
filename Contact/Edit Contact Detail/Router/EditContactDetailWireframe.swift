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
    func createModule() -> EditContactDetailViewController {
        let view = EditContactDetailViewController()
        let interactor = EditContactDetailInteractor()
        let wireframe = EditContactDetailWireframe()
        let presenter = EditContactDetailPresenter(view: view, interactor: interactor, wireframe: wireframe)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
    
    func pushToContactDetailScreen(navigationController: UINavigationController, contact: EditContactDetailEntity) {
        navigationController.popViewController(animated: true)
        if let viewController = navigationController.topViewController as? ContactDetailViewController {
            let contactDetail = ContactDetailEntity(id: contact.id,
                                                    firstName: contact.firstName,
                                                    lastName: contact.lastName,
                                                    email: contact.email,
                                                    phoneNumber: contact.phoneNumber,
                                                    profilePic: contact.profilePic,
                                                    isFavorite: contact.isFavorite,
                                                    createdAt: contact.createdAt,
                                                    updatedAt: contact.updatedAt,
                                                    rows: [("mobile", contact.phoneNumber),
                                                           ("email", contact.email)])
            viewController.showContactDetail(contact: contactDetail)
        }
    }
    
    func cancelToContactDetailScreen(navigationController: UINavigationController) {
        _ = navigationController.popViewController(animated: true)
    }
}
