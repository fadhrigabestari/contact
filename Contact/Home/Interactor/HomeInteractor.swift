//
//  HomeInteractor.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 05/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import Alamofire

class HomeInteractor: HomePresenterToInteractorProtocol {
    var presenter: HomeInteractorToPresenterProtocol?
    
    func fetchContacts() {
        guard let url = URL(string: "http://gojek-contacts-app.herokuapp.com/contacts.json") else {
            presenter?.contactsFetchFailed()
            return
        }
        
        Alamofire.request(url,
                          method: .get)
            .validate()
            .responseJSON {
                response in guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    self.presenter?.contactsFetchFailed()
                    return
                }
                
                guard let contacts = response.data else {
                    print("Malformed data received from FetchAllContacts service")
                    self.presenter?.contactsFetchFailed()
                    return
                }
                
                do {
                    let contactsDecoded = try JSONDecoder().decode([Contact].self, from: contacts)
                    self.presenter?.contactsFetchSuccess(contacts: contactsDecoded)
                    return
                } catch {
                    print(error)
                    self.presenter?.contactsFetchFailed()
                    return
                }
        }
    }
    
    
}
