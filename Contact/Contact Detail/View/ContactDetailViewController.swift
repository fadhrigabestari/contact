//
//  ContactDetailViewController.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 08/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    @IBOutlet weak var contactDetailTableView: UITableView!
    
    var categories = ["mobile", "email"]
    var contactDetail: ContactDetailView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = editButton
        
        let nib = UINib(nibName: "ContactDetailCell", bundle: nil)
        self.contactDetailTableView.register(nib, forCellReuseIdentifier: "ContactDetailCell")
        
        contactDetailTableView.dataSource = self
        contactDetailTableView.delegate = self
        // Do any additional setup after loading the view.
    }
}

extension ContactDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactDetailCell") as! ContactDetailCell
        
        switch(indexPath.row) {
        case 0:
            cell.contactDetailCategory.text = "mobile"
            cell.contactDetailLabel.text = contactDetail?.phoneNumber
            break
        case 1:
            cell.contactDetailCategory.text = "email"
            cell.contactDetailLabel.text = contactDetail?.email
            break
        default: break
            
        }
        
        return cell
    }
}
