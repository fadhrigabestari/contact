//
//  HomeViewController.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 04/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    var presenter: HomeViewToPresenterProtocol?

    @IBOutlet weak var contactTableView: UITableView!
    
    var contactCells: [ContactCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Contact"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        let groupsButton = UIBarButtonItem(title: "Groups", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = groupsButton
        let nib = UINib(nibName: "ContactViewCell", bundle: nil)
        self.contactTableView.register(nib, forCellReuseIdentifier: "ContactCell")
        
        presenter?.startFetchingContacts()
        
        contactTableView.dataSource = self
        contactTableView.delegate = self
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as! ContactViewCell
        
        applyRoundCorner(cell.contactImage)
        
        let contact = contactCells[indexPath.row]
        
        cell.selectionStyle = .none
        cell.contactName.text = contact.name
        if contact.profilePic.isValidURL {
            let url = URL(string: contact.profilePic)!
            cell.contactImage.load(url: url)
        } else {
            cell.contactImage.image = UIImage(named: "default-contact-image")
        }
        cell.contactFavourite.text = "⭑"
        cell.contactFavourite.isHidden = contact.isFavorite
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.onContactsCellPressed(navigationController: navigationController!, id: contactCells[indexPath.row].id)
    }
}
