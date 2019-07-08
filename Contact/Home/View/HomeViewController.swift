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
    var contacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ContactViewCell", bundle: nil)
        self.contactTableView.register(nib, forCellReuseIdentifier: "ContactCell")
        
        presenter?.startFetchingContacts()
        
        contactTableView.dataSource = self
        contactTableView.delegate = self
    }
}
