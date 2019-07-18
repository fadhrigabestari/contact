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
    var contactDict: [String:[ContactEntity]] = [:]
    let alphabets: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
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
    
    func onContactsCellPressed(navigationController: UINavigationController, id: Int) {
        wireframe?.pushToContactDetailScreen(navigationController: navigationController, id: id)
    }
    
    func contactsFetchSuccess(contacts: [Contact]) {
        view?.showContacts(contacts: streamlineContact(contacts: contacts), dictionary: filterContacts(contacts: contacts))
    }
    
    func contactsFetchFailed() {
        // view?.showFail()
    }
    
    func streamlineContact(contacts: [Contact]) -> [ContactEntity] {
        let contactEntities = contacts.map { (contact) -> ContactEntity in
            let name = "\(contact.firstName) \(contact.lastName)"
            let isFavorite = contact.isFavorite
            let contactEntity = ContactEntity(id: contact.id,
                                          name: name,
                                          profilePic: contact.profilePic,
                                          isFavorite: isFavorite)
            return contactEntity
        }
        
        return contactEntities
    }
    
    func filterContactByFavorite(contacts: [Contact]) -> [ContactEntity] {
        let contactEntities = contacts.filter{ (contact) -> Bool in
            return contact.isFavorite
            }.map { (contact) -> ContactEntity in
                let name = "\(contact.firstName) + \(contact.lastName)"
                let isFavorite = contact.isFavorite
                let contactEntity = ContactEntity(id: contact.id,
                                                  name: name,
                                                  profilePic: contact.profilePic,
                                                  isFavorite: isFavorite)
                return contactEntity
        }
        
        return contactEntities
    }
    
    func filterContactsByAlphabet(contacts: [Contact], alphabet: String) -> [ContactEntity] {
        let contactEntities = contacts.filter{ (contact) -> Bool in
            return !contact.isFavorite && contact.firstName.uppercased().first == alphabet.uppercased().first
            }.map { (contact) -> ContactEntity in
                let name = "\(contact.firstName) + \(contact.lastName)"
                let isFavorite = contact.isFavorite
                let contactEntity = ContactEntity(id: contact.id,
                                                  name: name,
                                                  profilePic: contact.profilePic,
                                                  isFavorite: isFavorite)
                return contactEntity
        }
        
        return contactEntities
    }
    
    func filterContactsByNonAlphabet(contacts: [Contact]) -> [ContactEntity] {
        let contactEntities = contacts.filter{ (contact) -> Bool in
            let regularExpressionForPhone = "[\\d\\!\\@\\#\\$\\%\\^\\&\\*\\(\\)\\-\\_\\+\\=\\`\\~\\[\\]\\{\\}\\;\\:\\,\\<\\.\\>\\/\\?].*"
            let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
            return testPhone.evaluate(with: contact.firstName)
            }.map { (contact) -> ContactEntity in
                let name = "\(contact.firstName) + \(contact.lastName)"
                let isFavorite = contact.isFavorite
                let contactEntity = ContactEntity(id: contact.id,
                                                  name: name,
                                                  profilePic: contact.profilePic,
                                                  isFavorite: isFavorite)
                return contactEntity
        }
        
        return contactEntities
    }
    
    func filterContacts(contacts: [Contact]) -> [String:[ContactEntity]] {
        var result: [String:[ContactEntity]] = [:]
        let favoritedContacts = filterContactByFavorite(contacts: contacts)
        var alphabetContact: [ContactEntity]
        let nonAlphabetContact = filterContactsByNonAlphabet(contacts: contacts)
        
        if favoritedContacts.count > 0 {
            result["Favorite"] = favoritedContacts
        }
        
        for alphabet in alphabets {
            alphabetContact = filterContactsByAlphabet(contacts: contacts, alphabet: alphabet)
            if alphabetContact.count > 0 {
                result[alphabet] = alphabetContact
            }
        }
        
        if nonAlphabetContact.count > 0 {
            result["#"] = nonAlphabetContact
        }
        
        return result
    }
}
