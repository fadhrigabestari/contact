//
//  HomeInteractor.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 05/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

class HomeInteractor: IHomeInteractor {
    weak var presenter: IHomePresenter?
    
    func fetchContacts() {
        let contacts = fetchCoreData()
        self.presenter?.contactsFetchSuccess(contacts: contacts)
        
        guard let url = URL(string: "http://gojek-contacts-app.herokuapp.com/contacts.json") else {
            presenter?.contactsFetchFailed()
            return
        }
        
        Alamofire.request(url,
                          method: .get)
            .validate().responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    self.presenter?.contactsFetchFailed()
                    return
                }
                
                guard let contacts = response.data else {
                    print("Malformed data received from FetchAllContacts service")
                    self.presenter?.contactsFetchFailed()
                    return
                }
                
                self.clearCoreData()
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                    let contactsDecoded = try decoder.decode([Contact].self, from: contacts)
                    if self.saveContactToCoreData(contacts: contactsDecoded) {
                        self.presenter?.contactsFetchSuccess(contacts: contactsDecoded)
                    } else {
                        self.presenter?.contactsFetchFailed()
                    }
                    return
                } catch {
                    print(error)
                    self.presenter?.contactsFetchFailed()
                    return
                }
        }
    }
}

private extension HomeInteractor {
    func saveContactToCoreData(contacts: [Contact]) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let contactEntity = NSEntityDescription.entity(forEntityName: "ContactCore", in: managedContext)
        
        for item in contacts {
            let contact = NSManagedObject(entity: contactEntity!, insertInto: managedContext)
            contact.setValue(item.id, forKey: "id")
            contact.setValue(item.firstName, forKey: "firstName")
            contact.setValue(item.lastName, forKey: "lastName")
            contact.setValue(item.email, forKey: "email")
            contact.setValue(item.phoneNumber, forKey: "phoneNumber")
            contact.setValue(item.profilePic, forKey: "profilePic")
            contact.setValue(item.isFavorite, forKey: "isFavorite")
            contact.setValue(item.createdAt, forKey: "createdAt")
            contact.setValue(item.updatedAt, forKey: "updatedAt")
            contact.setValue(item.url, forKey: "url")
        }
        
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
            return false
        }
    }
    
    func fetchCoreData() -> [Contact] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ContactCore>(entityName: "ContactCore")
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
    
    func clearCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ContactCore")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedContext.execute(batchDeleteRequest)
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
            return
        }
    }
}
