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
    
    func onFavoriteButtonPressed(navigationController: UINavigationController) {
        //
    }
    
    func onEditButtonPressed(navigationController: UINavigationController, contact: ContactDetailEntity) {
        wireframe?.pushToEditScreen(navigationController: navigationController, contact: contact)
    }
    
    func startFetchingContactDetail(id: Int) {
        interactor?.fetchContactDetail(id: id)
    }
    
    func contactDetailFetchSuccess(contact: ContactDetail) {
        let contact = ContactDetailEntity(
            firstName: contact.firstName,
            lastName: contact.lastName,
            profilePic: contact.profilePic,
            phoneNumber: contact.phoneNumber,
            email: contact.email,
            isFavorite: contact.isFavorite)
        
        view?.showContactDetail(contact: contact)
    }
    
    func contactDetailFetchFailed() {
        //
    }
}
