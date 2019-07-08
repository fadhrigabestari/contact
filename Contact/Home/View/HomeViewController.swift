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
    
    var button: UIButton!

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
