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
                let contactDetailDecoded = try JSONDecoder().decode(ContactDetail.self, from: contactDetail)
                self.presenter?.contactDetailFetchSuccess(contactDetail: contactDetailDecoded)
                return
            } catch {
                print(error)
                self.presenter?.contactDetailFetchFailed()
                return
            }
        }
    }
}
