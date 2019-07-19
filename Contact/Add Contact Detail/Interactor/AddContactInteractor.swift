//
//  AddContactInteractor.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 18/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

class AddContactInteractor: IAddContactInteractor {
    weak var presenter: IAddContactPresenter?
    
    func sendAddContact(navigationController: UINavigationController, contact: Contact) {
        guard let url = URL(string: "https://gojek-contacts-app.herokuapp.com/contacts.json") else {
            presenter?.sendAddContactFailed()
            return
        }
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601Full)
        do {
            let jsonData = try encoder.encode(contact)
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            Alamofire.request(request).responseJSON { response in
                print(response)
                guard response.result.isSuccess else {
                    self.presenter?.sendAddContactFailed()
                    return
                }
                
                guard let newContact = response.data else {
                    print("Malformed data received from FetchContactDetail service")
                    self.presenter?.sendAddContactFailed()
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                    let contactDecoded = try decoder.decode(Contact.self, from: newContact)
                    if self.saveContactDetailToCoreData(contact: contactDecoded) {
                        self.presenter?.sendAddContactSuccess(navigationController: navigationController, contact: contactDecoded)
                    } else {
                        self.presenter?.sendAddContactFailed()
                    }
                    return
                } catch {
                    print(error)
                    self.presenter?.sendAddContactFailed()
                    return
                }
            }
        } catch {
            print(error)
            self.presenter?.sendAddContactFailed()
            return
        }
    }
}

private extension AddContactInteractor {
    func saveContactDetailToCoreData(contact: Contact) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ContactCore", in: managedContext)
        
        let contactCore = NSManagedObject(entity: entity!, insertInto: managedContext)
        contactCore.setValue(contact.id, forKey: "id")
        contactCore.setValue(contact.firstName, forKey: "firstName")
        contactCore.setValue(contact.lastName, forKey: "lastName")
        contactCore.setValue(contact.email, forKey: "email")
        contactCore.setValue(contact.phoneNumber, forKey: "phoneNumber")
        contactCore.setValue(contact.profilePic, forKey: "profilePic")
        contactCore.setValue(contact.isFavorite, forKey: "isFavorite")
        contactCore.setValue(contact.createdAt, forKey: "createdAt")
        contactCore.setValue(contact.updatedAt, forKey: "updatedAt")
        contactCore.setValue(contact.url, forKey: "url")
        
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
            return false
        }
    }
}
