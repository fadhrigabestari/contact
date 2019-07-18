//
//  AddContactInteractor.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 18/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import Alamofire

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
                guard response.result.isSuccess else {
                    self.presenter?.sendAddContactFailed()
                    return
                }
                
                self.presenter?.sendAddContactSuccess(navigationController: navigationController, contact: contact)
                return
            }
        } catch {
            print(error)
            self.presenter?.sendAddContactFailed()
            return
        }
    }
}
