//
//  EditContactDetailViewController+IEditContactDetailView.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 10/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit

extension EditContactDetailViewController: IEditContactDetailView {
    func showEditedProfilePicture() {
        //
    }
    
    func showEditedContactDetail(contact: EditContactDetailEntity) {
        self.navigationController?.popViewController(animated: true)
        if let viewController = self.navigationController?.topViewController as? ContactDetailViewController {
            let contactDetail = ContactDetailEntity(id: contact.id,
                                              firstName: contact.firstName,
                                              lastName: contact.lastName,
                                              email: contact.email,
                                              phoneNumber: contact.phoneNumber,
                                              profilePic: contact.profilePic,
                                              isFavorite: contact.isFavorite,
                                              createdAt: contact.createdAt,
                                              updatedAt: contact.updatedAt,
                                              rows: [("mobile", contact.phoneNumber),
                                                     ("email", contact.email)])
            viewController.showContactDetail(contact: contactDetail)
        }
    }
    
    func showSendEditedContactDetailError() {
        //
    }
    
    func showEditContactDetailSuccess() {
        let alert = UIAlertController(title: "", message: "Contact detail successfully changed", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
    }
}
