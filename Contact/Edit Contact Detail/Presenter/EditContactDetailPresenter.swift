//
//  File.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 10/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit

class EditContactDetailPresenter: IEditContactDetailPresenter {
    weak var view: IEditContactDetailView?
    var interactor: IEditContactDetailInteractor?
    var wireframe: IEditContactDetailWireframe?
    
    init(view: IEditContactDetailView, interactor: IEditContactDetailInteractor, wireframe: IEditContactDetailWireframe) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    func onDoneButtonPressed(navigationController: UINavigationController, contact: EditContactDetailEntity) {
        var updatedContact = contact
        updatedContact.updatedAt = Date()
        if contact.phoneNumber.first != "+" {
            updatedContact.phoneNumber = "+\(contact.phoneNumber)"
        }
        interactor?.sendEditedContactDetail(navigationController: navigationController, contact: updatedContact.toContactModel)
    }
    
    func onEditPictureButtonPressed() {
        //
    }
    
    func sendEditedContactDetailSuccess(navigationController: UINavigationController, contact: Contact) {
        wireframe?.pushToContactDetailScreen(navigationController: navigationController, contact: contact)
    }
    
    func sendEditedContactDetailFailed() {
        view?.showSendEditedContactDetailFailed()
    }
    
    func onCancelButtonPressed(navigationController: UINavigationController) {
        wireframe?.cancelToContactDetailScreen(navigationController: navigationController)
    }
}
