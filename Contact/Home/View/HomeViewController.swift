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
    var presenter: IHomePresenter?

    @IBOutlet weak var tableView: UITableView!
    
    var contactCollection: [ContactCollection] = []
    var progressHUD = ProgressHUD(text: "Loading")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
        setupProgressHUD()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter?.startFetchingContacts()
    }
    
    private func setupNavigationBar() {
        self.title = "Contact"
        self.navigationController?.navigationBar.tintColor = "#50E3C2".toUIColor()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tappedAddButton))
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
    
    private func setupProgressHUD() {
        self.view.addSubview(progressHUD)
        self.progressHUD.show()
    }
    
    @objc func tappedAddButton() {
        presenter?.onAddButtonPressed(navigationController: self.navigationController!)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.contactCollection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contactCollection[section].contacts.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.contactCollection[section].sectionName
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as! ContactViewCell
        
        applyRoundCorner(cell.contactImage)
        
        let contact = contactCollection[indexPath.section].contacts[indexPath.row]
        
        cell.selectionStyle = .none
        cell.contactName.text = contact.name
        if contact.profilePic.isValidURL {
            let url = URL(string: contact.profilePic)!
            cell.contactImage.load(url: url)
        } else {
            cell.contactImage.image = UIImage(named: "default-contact-image")
        }
        cell.contactFavourite.text = "⭑"
        cell.contactFavourite.isHidden = !contact.isFavorite
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.onContactsCellPressed(navigationController: navigationController!, id: contactCollection[indexPath.section].contacts[indexPath.row].id)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var sectionsTitles: [String] = []
        for contacts in contactCollection {
            if contacts.sectionName == "Favorite" {
                sectionsTitles.append("⭑")
            } else {
                sectionsTitles.append(contacts.sectionName)
            }
        }
        
        return sectionsTitles
    }
}
