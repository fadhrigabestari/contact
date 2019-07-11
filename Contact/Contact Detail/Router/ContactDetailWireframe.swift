//
//  ContactDetailWireframe.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 08/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit

class ContactDetailWireframe: IContactDetailWireframe {
    internal func createModule() -> ContactDetailViewController {
        let view = ContactDetailViewController(nibName: "ContactDetailViewController", bundle: nil)
        let interactor = ContactDetailInteractor()
        let presenter = ContactDetailPresenter(view: view, interactor: interactor, wireframe: self)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
    
    func pushToMessageScreen(number: String) {
        UIApplication.shared.open(URL(string: "sms:+\(number)")!, options: [:], completionHandler: nil)
    }
    
    func pushToCallScreen(number: String) {
        UIApplication.shared.open(URL(string: "tel:+\(number)")!, options: [:], completionHandler: nil)
    }
    
    func pushToEmailScreen(email: String) {
        UIApplication.shared.open(URL(string: "mailto:+\(email)")!, options: [:], completionHandler: nil)
    }
    
    func pushToEditScreen(navigationController: UINavigationController, contact: ContactDetailEntity) {
        let editContactDetailWireframe = EditContactDetailWireframe()
        let editContactDetailViewController = editContactDetailWireframe.createModule()
        
        let rows = [("First Name", contact.firstName, "John"),
                    ("Last Name", contact.lastName, "Doe"),
                    ("mobile", contact.phoneNumber, "+81234567890"),
                    ("email", contact.email, "john.doe@gmail.com")]
        let contact = EditContactDetailEntity(firstName: contact.firstName, lastName: contact.lastName, profilePic: contact.profilePic, phoneNumber: contact.phoneNumber, email: contact.email, rows: rows)
        editContactDetailViewController.contact = contact
        navigationController.navigationItem.hidesBackButton = true
        navigationController.pushViewController(editContactDetailViewController, animated: true)
    }
}
