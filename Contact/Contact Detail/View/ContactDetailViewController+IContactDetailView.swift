//
//  ContactDetailViewController+IContactDetailView.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 08/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit

extension ContactDetailViewController: IContactDetailView {
    func showContactDetail(contact: ContactDetailEntity) {
        self.contact = contact
        if contact.profilePic.isValidURL {
            self.profilePicture.load(url: URL(string: contact.profilePic)!)
        } else {
            self.profilePicture.image = UIImage(named: "default-contact-image")
        }
        if contact.isFavorite {
            self.favoriteIcon.backgroundColor = UIColor.white
            self.favoriteIconImageView.image = UIImage(named: "non-favorite-icon-grey")
        } else {
            self.favoriteIcon.backgroundColor = "#50E3C2".toUIColor()
            self.favoriteIconImageView.image = UIImage(named: "favorite-icon")
        }
        self.profilePicture.roundImage()
        self.fullName.text = "\(contact.firstName) \(contact.lastName)"
        
        self.rows.append(("mobile", contact.phoneNumber))
        self.rows.append(("email", contact.email))
        self.tableView.reloadData()
    }
}
