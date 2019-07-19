//
//  AddContactPresenter.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 18/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit

class AddContactPresenter: IAddContactPresenter {
    weak var view: IAddContactView?
    var interactor: IAddContactInteractor?
    var wireframe: IAddContactWireframe?
    
    init(view: IAddContactView, interactor: IAddContactInteractor, wireframe: IAddContactWireframe) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    func onDoneButtonPressed(navigationController: UINavigationController, contact: AddContactEntity) {
        let contactModel = contact.toContactModel
        interactor?.sendAddContact(navigationController: navigationController, contact: contactModel)
    }
    
    func onCancelButtonPressed(navigationController: UINavigationController) {
        wireframe?.cancelToHomeScreen(navigationController: navigationController)
    }
    
    func sendAddContactSuccess(navigationController: UINavigationController, contact: Contact) {
        wireframe?.popToHomeScreen(navigationController: navigationController, contact: contact)
    }
    
    func sendAddContactFailed() {
        view?.showSendAddContactFailed()
    }
}
