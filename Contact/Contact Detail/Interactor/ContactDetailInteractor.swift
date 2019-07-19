//
//  ContactDetailInteractor.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 08/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

class ContactDetailInteractor: IContactDetailInteractor {
    weak var presenter: IContactDetailPresenter?
    
    func fetchContactDetail(id: Int) {
        guard let url = URL(string: "https://gojek-contacts-app.herokuapp.com/contacts/\(id).json") else {
            presenter?.contactDetailFetchFailed()
            return
        }
        
        Alamofire.request(url,
                          method: .get)
        .validate().responseJSON {
            response in guard response.result.isSuccess else {
                print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                self.presenter?.contactDetailFetchFailed()
                return
            }
            
            guard let contactDetail = response.data else {
                print("Malformed data received from FetchContactDetail service")
                self.presenter?.contactDetailFetchFailed()
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                let contactDetailDecoded = try decoder.decode(Contact.self, from: contactDetail)
                if self.saveContactDetailToCoreData(id: id, contact: contactDetailDecoded) {
                    self.presenter?.contactDetailFetchSuccess(contact: contactDetailDecoded)
                } else {
                    self.presenter?.contactDetailFetchFailed()
                }
                return
            } catch {
                print(error)
                self.presenter?.contactDetailFetchFailed()
                return
            }
        }
    }
    
    func sendContactDetail(contact: Contact) {
        guard let url = URL(string: "https://gojek-contacts-app.herokuapp.com/contacts/\(contact.id).json") else {
            presenter?.sendContactDetailFailed()
            return
        }
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601Full)
        do {
            let jsonData = try encoder.encode(contact)
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.put.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            Alamofire.request(request).responseJSON {response in
                guard response.result.isSuccess else {
                    self.presenter?.sendContactDetailFailed()
                    return
                }
                
                if self.saveContactDetailToCoreData(id: contact.id, contact: contact) {
                    self.presenter?.sendContactDetailSuccess(contact: contact)
                } else {
                    self.presenter?.sendContactDetailFailed()
                }
                return
            }
        } catch {
            print(error)
            self.presenter?.sendContactDetailFailed()
            return
        }
    }
}

private extension ContactDetailInteractor {
    func saveContactDetailToCoreData(id: Int, contact: Contact) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<ContactCore> = NSFetchRequest(entityName: "ContactCore")
        fetchRequest.predicate = NSPredicate(format: "id == %ld", id)
        do {
            let contacts = try managedContext.fetch(fetchRequest)
            contacts[0].setValue(contact.email, forKey: "email")
            contacts[0].setValue(contact.createdAt, forKey: "createdAt")
            contacts[0].setValue(contact.updatedAt, forKey: "updatedAt")
            contacts[0].setValue(contact.phoneNumber, forKey: "phoneNumber")
            contacts[0].setValue(contact.isFavorite, forKey: "isFavorite")
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
            return false
        }
    }
    
    func fetchCoreData(id: Int) -> [Contact] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ContactCore>(entityName: "ContactCore")
        fetchRequest.predicate = NSPredicate(format: "id == %ld", id)
        do {
            var contacts: [Contact] = []
            let contactsCore = try managedContext.fetch(fetchRequest)
            for contactCore in contactsCore {
                contacts.append(Contact(id: Int(contactCore.id),
                                        firstName: contactCore.firstName ?? "",
                                        lastName: contactCore.lastName ?? "",
                                        email: contactCore.email,
                                        profilePic: contactCore.profilePic ?? "",
                                        phoneNumber: contactCore.phoneNumber,
                                        isFavorite: contactCore.isFavorite,
                                        url: contactCore.url,
                                        createdAt: contactCore.createdAt,
                                        updatedAt: contactCore.updatedAt))
            }
            return contacts
        } catch let error {
            print(error)
            return []
        }
    }
}
