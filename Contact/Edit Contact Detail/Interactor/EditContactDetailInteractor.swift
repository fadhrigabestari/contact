//
//  EditContactDetailInteractor.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 10/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import Alamofire

class EditContactDetailInteractor: IEditContactDetailInteractor {
    var presenter: IEditContactDetailPresenter?
    
    func sendEditedContactDetail(contact: EditContactDetailEntity) {
        guard let url = URL(string: "https://gojek-contacts-app.herokuapp.com/contacts/\(contact.id).json") else {
            presenter?.sendEditedContactDetailFailed()
            return
        }
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(DateFormatter.iso8601Full)
        do {
            print(contact)
            let  jsonData = try encoder.encode(Contact(id: contact.id,
                                                       firstName: contact.firstName,
                                                       lastName: contact.lastName,
                                                       email: contact.email,
                                                       profilePic: contact.profilePic,
                                                       phoneNumber: contact.phoneNumber,
                                                       isFavorite: contact.isFavorite,
                                                       url: nil, createdAt: contact.createdAt,
                                                       updatedAt: contact.updatedAt))
            var request = URLRequest(url: url)
            request.httpMethod = HTTPMethod.put.rawValue
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            Alamofire.request(request).responseJSON { response in
                guard response.result.isSuccess else {
                    self.presenter?.sendEditedContactDetailFailed()
                    return
                }
                
                self.presenter?.sendEditedContactDetailSuccess(contact: contact)
                return
            }
        } catch {
            print(error)
            self.presenter?.sendEditedContactDetailFailed()
            return
        }
    }
}
