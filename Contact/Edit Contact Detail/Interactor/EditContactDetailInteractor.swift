//
//  EditContactDetailInteractor.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 10/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import Alamofire
import CoreData

class EditContactDetailInteractor: IEditContactDetailInteractor {
    var presenter: IEditContactDetailPresenter?
    
    func sendEditedContactDetail(navigationController: UINavigationController, contact: Contact) {
        guard let url = URL(string: "https://gojek-contacts-app.herokuapp.com/contacts/\(contact.id).json") else {
            presenter?.sendEditedContactDetailFailed()
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
            
            Alamofire.request(request).responseJSON { response in
                guard response.result.isSuccess else {
                    self.presenter?.sendEditedContactDetailFailed()
                    return
                }
                
                guard let newContact = response.data else {
                    print("Malformed data received from FetchContactDetail service")
                    self.presenter?.sendEditedContactDetailFailed()
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
                    let contactDecoded = try decoder.decode(Contact.self, from: newContact)
                    if self.saveContactDetailToCoreData(contact: contactDecoded) {
                        self.presenter?.sendEditedContactDetailSuccess(navigationController: navigationController, contact: contactDecoded)
                    } else {
                        self.presenter?.sendEditedContactDetailFailed()
                    }
                    return
                } catch {
                    print(error)
                    self.presenter?.sendEditedContactDetailFailed()
                    return
                }
            }
        } catch {
            print(error)
            self.presenter?.sendEditedContactDetailFailed()
            return
        }
    }
}

private extension EditContactDetailInteractor {
    func saveContactDetailToCoreData(contact: Contact) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<ContactCore> = NSFetchRequest(entityName: "ContactCore")
        fetchRequest.predicate = NSPredicate(format: "id == %ld", contact.id)
        do {
            let contacts = try managedContext.fetch(fetchRequest)
            contacts[0].setValue(contact.firstName, forKey: "firstName")
            contacts[0].setValue(contact.lastName, forKey: "lastName")
            contacts[0].setValue(contact.email, forKey: "email")
            contacts[0].setValue(contact.phoneNumber, forKey: "phoneNumber")
            contacts[0].setValue(contact.updatedAt, forKey: "updatedAt")
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("\(error), \(error.userInfo)")
            return false
        }
    }
}
