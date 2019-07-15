//
//  ContactDetailInteractor.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 08/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import Alamofire

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
                self.presenter?.contactDetailFetchSuccess(contact: contactDetailDecoded)
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
                
                self.presenter?.sendContactDetailSuccess(contact: contact)
                return
            }
        } catch {
            print(error)
            self.presenter?.sendContactDetailFailed()
            return
        }
    }
}
