//
//  HomeViewController+UITableView.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 08/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as! ContactViewCell
        
        let cellImageLayer: CALayer? = cell.contactImage.layer
        cellImageLayer!.cornerRadius = cell.contactImage.frame.width / 2
        cellImageLayer!.masksToBounds = true
        
        let contact = contacts[indexPath.row]
        
        cell.selectionStyle = .none
        cell.contactName.text = "\(contact.firstName) \(contact.lastName)"
        cell.contactFavourite.text = contact.isFavorite ? "⭑" : ""
        if contact.profilePic.isValidURL {
            let url = URL(string: contact.profilePic)!
            cell.contactImage.load(url: url)
        } else {
            cell.contactImage.image = UIImage(named: "default-contact-image")
        }
        
        return cell
    }
}
