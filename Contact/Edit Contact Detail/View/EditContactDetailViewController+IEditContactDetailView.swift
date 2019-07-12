//
//  EditContactDetailViewController+IEditContactDetailView.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 10/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation

extension EditContactDetailViewController: IEditContactDetailView {
    func showEditedProfilePicture() {
        //
    }
    
    func showEditedContactDetail(contact: EditContactDetailEntity) {
        self.contact.rows = [("First Name", contact.firstName, "John"),
                             ("Last Name", contact.lastName, "Doe"),
                             ("mobile", contact.phoneNumber, "+81234567890"),
                             ("email", contact.email, "john.doe@gmail.com")]
        self.tableView.reloadData()
    }
    
    func showSendEditedContactDetailError() {
        //
    }
}
