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
            self.favoriteIcon.backgroundColor = "#50E3C2".toUIColor()
            self.favoriteIconImageView.image = UIImage(named: "favorite-icon")
        } else {
            self.favoriteIcon.backgroundColor = UIColor.white
            self.favoriteIconImageView.image = UIImage(named: "non-favorite-icon-grey")
        }
        self.profilePicture.roundImage()
        self.fullName.text = "\(contact.firstName) \(contact.lastName)"
        self.tableView.reloadData()
    }
    
    func showSendContactDetailSuccess() {
        let alert = UIAlertController(title: "", message: "Contact successfully favorited", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
    }
}
