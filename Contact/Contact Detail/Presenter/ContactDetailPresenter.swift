//
//  ContactDetailPresenter.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 08/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit

class ContactDetailPresenter: IContactDetailPresenter {
    weak var view: IContactDetailView?
    var interactor: IContactDetailInteractor?
    var wireframe: IContactDetailWireframe?
    
    var createdAt: Date?
    var updatedAt: Date?
    
    init(view: IContactDetailView, interactor: IContactDetailInteractor, wireframe: IContactDetailWireframe) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    func onMessageButtonPressed(number: String) {
        wireframe?.pushToMessageScreen(number: number)
    }
    
    func onCallButtonPressed(number: String) {
        wireframe?.pushToCallScreen(number: number)
    }
    
    func onEmailButtonPressed(email: String) {
        wireframe?.pushToEmailScreen(email: email)
    }
    
    func onFavoriteButtonPressed(contact: ContactDetailEntity) {
        let contactModel = Contact(id: contact.id,
                                   firstName: contact.firstName,
                                   lastName: contact.lastName,
                                   email: contact.email,
                                   profilePic: contact.profilePic,
                                   phoneNumber: contact.phoneNumber,
                                   isFavorite: contact.isFavorite,
                                   url: nil,
                                   createdAt: contact.createdAt,
                                   updatedAt: contact.updatedAt)
        interactor?.sendContactDetail(contact: contactModel)
    }
    
    func onEditButtonPressed(navigationController: UINavigationController, contact: ContactDetailEntity) {
        wireframe?.pushToEditScreen(navigationController: navigationController, contact: contact)
    }
    
    func startFetchingContactDetail(id: Int) {
        interactor?.fetchContactDetail(id: id)
    }
    
    func contactDetailFetchSuccess(contact: Contact) {
        let contactDetail = ContactDetailEntity(
            id: contact.id,
            firstName: contact.firstName,
            lastName: contact.lastName,
            email: contact.email!,
            phoneNumber: contact.phoneNumber!,
            profilePic: contact.profilePic,
            isFavorite: contact.isFavorite,
            createdAt: contact.createdAt!,
            updatedAt: contact.updatedAt!,
            rows: [("mobile", contact.phoneNumber!),
                   ("email", contact.email!)])
        
        view?.showContactDetail(contact: contactDetail)
    }
    
    func contactDetailFetchFailed() {
        //
    }
    
    func sendContactDetailSuccess(contact: Contact) {
        if contact.isFavorite {
            view?.showSendContactDetailSuccess()
        }
    }
    
    func sendContactDetailFailed() {
        //
    }
}
