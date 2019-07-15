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
    
    func onDoneButtonPressed(contact: EditContactDetailEntity) {
        var editedContact = contact
        editedContact.updatedAt = Date()
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
        let editContactDetail = EditContactDetailEntity(
            id: contact.id,
            firstName: contact.firstName,
            lastName: contact.lastName,
            email: contact.email!,
            phoneNumber: contact.phoneNumber!,
            profilePic: contact.profilePic,
            isFavorite: contact.isFavorite,
            createdAt: contact.createdAt!,
            updatedAt: contact.updatedAt!,
            rows: [("First Name", contact.firstName, "John"),
                   ("Last Name", contact.lastName, "Doe"),
                   ("mobile", contact.phoneNumber!, "+81234567890"),
                   ("email", contact.email!, "john.doe@gmail.com")])
        view?.showEditedContactDetail(contact: editContactDetail)
    }
    
    func sendEditedContactDetailFailed() {
        view?.showSendEditedContactDetailError()
    }
    
    func onCancelButtonPressed(navigationController: UINavigationController) {
        wireframe?.pushToContactDetailScreen(navigationController: navigationController)
    }
}
