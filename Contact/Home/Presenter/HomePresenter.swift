//
//  HomePresenter.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 05/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit

class HomePresenter: HomeViewToPresenterProtocol, HomeInteractorToPresenterProtocol {
    weak var view: HomePresenterToViewProtocol?
    var interactor: HomePresenterToInteractorProtocol?
    var wireframe: HomePresenterToWireframeProtocol?
    
    init(view: HomePresenterToViewProtocol, interactor: HomePresenterToInteractorProtocol, wireframe: HomePresenterToWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    func startFetchingContacts() {
        interactor?.fetchContacts()
    }
    
    func onAddButtonPressed(navigationController: UINavigationController) {
        wireframe?.pushToAddScreen(navigationController: navigationController)
    }
    
    func onGroupsButtonPressed(navigationController: UINavigationController) {
        wireframe?.pushToGroupsScreen(navigationController: navigationController)
    }
    
    func onContactsCellPressed(navigationController: UINavigationController) {
        wireframe?.pushToContactDetailScreen(navigationController: navigationController)
    }
    
    func contactsFetchSuccess(contacts: [Contact]) {
        view?.showContacts(contactCells: streamlineContact(contacts: contacts))
    }
    
    func contactsFetchFailed() {
        // view?.showFail()
    }
    
    func streamlineContact(contacts: [Contact]) -> [ContactCell] {
        let contactCells = contacts.map { (contact) -> ContactCell in
            let name = "\(contact.firstName) \(contact.lastName)"
            let isFavorite = contact.isFavorite ? "⭑" : ""
            let contactCell = ContactCell(id: contact.id,
                                          name: name,
                                          profilePic: contact.profilePic,
                                          isFavorite: isFavorite)
            return contactCell
        }
        
        return contactCells
    }
}
