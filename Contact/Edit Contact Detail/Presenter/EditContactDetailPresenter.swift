//
//  File.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 10/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation

class EditContactDetailPresenter: IEditContactDetailPresenter {
    weak var view: IEditContactDetailView?
    var interactor: IEditContactDetailInteractor?
    var wireframe: IEditContactDetailWireframe?
    
    init(view: IEditContactDetailView, interactor: IEditContactDetailInteractor, wireframe: IEditContactDetailWireframe) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    func onDoneButtonPressed(contact: ContactDetailView) {
        interactor?.sendEditedContactDetail(contact: contact)
    }
    
    func onEditPictureButtonPressed() {
        view?.showEditedProfilePicture()
    }
    
    func sendEditedContactDetailSuccess(contact: ContactDetailView) {
        view?.showEditedContactDetail(contact: contact)
    }
    
    func sendEditedContactDetailFailed() {
        view?.showSendEditedContactDetailError()
    }
}
