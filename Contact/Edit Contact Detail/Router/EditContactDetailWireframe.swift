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
    weak var delegate: ContactDetailDelegate?
    
    func createModule(delegate: ContactDetailDelegate) -> EditContactDetailViewController {
        let view = EditContactDetailViewController()
        let interactor = EditContactDetailInteractor()
        let presenter = EditContactDetailPresenter(view: view, interactor: interactor, wireframe: self)
        
        view.presenter = presenter
        interactor.presenter = presenter
        self.delegate = delegate
        
        return view
    }
    
    func pushToContactDetailScreen(navigationController: UINavigationController, contact: Contact) {
        delegate?.onContactEditted(contact: contact)
        navigationController.popViewController(animated: true)
    }
    
    func cancelToContactDetailScreen(navigationController: UINavigationController) {
        _ = navigationController.popViewController(animated: true)
    }
}
