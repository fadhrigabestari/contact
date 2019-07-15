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
        interactor?.sendEditedContactDetail(contact: editedContact)
    }
    
    func onEditPictureButtonPressed() {
        view?.showEditedProfilePicture()
    }
    
    func sendEditedContactDetailSuccess(contact: EditContactDetailEntity) {
        view?.showEditedContactDetail(contact: contact)
    }
    
    func sendEditedContactDetailFailed() {
        view?.showSendEditedContactDetailError()
    }
    
    func onCancelButtonPressed(navigationController: UINavigationController) {
        wireframe?.pushToContactDetailScreen(navigationController: navigationController)
    }
}
