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
    func showContactDetail(contactDetail: ContactDetailView) {
        if contactDetail.profilePic.isValidURL {
            let url = URL(string: contactDetail.profilePic)!
            self.profilePicture.load(url: url)
        } else {
            self.profilePicture.image = UIImage(named: "default-contact-image")
        }
        if contactDetail.isFavorite {
            self.favoriteIcon.backgroundColor = UIColor.white
            self.favoriteIconImageView.image = UIImage(named: "non-favorite-icon-grey")
        } else {
            self.favoriteIcon.backgroundColor = UIColor.blue
            self.favoriteIconImageView.image = UIImage(named: "favorite-icon")
        }
        self.profilePicture.roundImage()
        self.fullName.text = "\(contactDetail.firstName) \(contactDetail.lastName)"
        self.contactDetail = contactDetail
        self.contactDetailTableView.reloadData()
    }
}
