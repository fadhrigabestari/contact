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

    @IBOutlet weak var tableView: UITableView!
    
    var contacts: [ContactEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let timestamp = NSDate().timeIntervalSince1970
        
        print(timestamp)
        
        setupNavigationBar()
        setupTableView()
        presenter?.startFetchingContacts()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupNavigationBar() {
        self.title = "Contact"
        self.navigationController?.navigationBar.tintColor = "#50E3C2".toUIColor()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        let groupsButton = UIBarButtonItem(title: "Groups", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = groupsButton
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "ContactViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "ContactCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 64
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as! ContactViewCell
        
        applyRoundCorner(cell.contactImage)
        
        let contact = contacts[indexPath.row]
        
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
        presenter?.onContactsCellPressed(navigationController: navigationController!, id: contacts[indexPath.row].id)
    }
}
