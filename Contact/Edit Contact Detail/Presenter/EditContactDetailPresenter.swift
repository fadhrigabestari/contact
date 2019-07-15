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
        var editedContact = contact
        editedContact.updatedAt = Date()
        wireframe?.pushToContactDetailScreen(navigationController: navigationController, contact: editedContact)
        let contactModel = Contact(id: editedContact.id,
                                   firstName: editedContact.firstName,
                                   lastName: editedContact.lastName,
                                   email: editedContact.email,
                                   profilePic: editedContact.profilePic,
                                   phoneNumber: editedContact.phoneNumber,
                                   isFavorite: editedContact.isFavorite,
                                   url: nil,
                                   createdAt: editedContact.createdAt,
                                   updatedAt: editedContact.updatedAt)
        interactor?.sendEditedContactDetail(contact: contactModel)
    }
    
    func onEditPictureButtonPressed() {
        view?.showEditedProfilePicture()
    }
    
    func sendEditedContactDetailSuccess(contact: Contact) {
        view?.showEditContactDetailSuccess()
    }
    
    func sendEditedContactDetailFailed() {
        view?.showSendEditedContactDetailError()
    }
    
    func onCancelButtonPressed(navigationController: UINavigationController) {
        wireframe?.cancelToContactDetailScreen(navigationController: navigationController)
    }
}
