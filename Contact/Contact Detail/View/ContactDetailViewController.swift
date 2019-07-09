//
//  ContactDetailViewController.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 08/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    var id: Int?
    var presenter: IContactDetailPresenter?
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var messageIcon: UIImageView!
    @IBOutlet weak var callIcon: UIImageView!
    @IBOutlet weak var emailIcon: UIImageView!
    @IBOutlet weak var favoriteIcon: UIImageView!
    
    @IBOutlet weak var contactDetailTableView: UITableView!
    
    var categories = ["mobile", "email"]
    var contactDetail: ContactDetailView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = editButton
        
        let nib = UINib(nibName: "ContactDetailViewCell", bundle: nil)
        self.contactDetailTableView.register(nib, forCellReuseIdentifier: "ContactDetailCell")
        
        self.profilePicture.roundImage()
        
        insertImageToIcon()
        presenter?.startFetchingContactDetail(id: id!)
        
        contactDetailTableView.dataSource = self
        contactDetailTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func insertImageToIcon() {        
        messageIcon.image = UIImage(named: "default-contact-image")
        callIcon.image = UIImage(named: "default-contact-image")
        emailIcon.image = UIImage(named: "default-contact-image")
        favoriteIcon.image = UIImage(named: "default-contact-image")
        
        self.messageIcon.roundImage()
        self.callIcon.roundImage()
        self.emailIcon.roundImage()
        self.favoriteIcon.roundImage()
    }
}

extension ContactDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactDetailCell") as! ContactDetailViewCell
        
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
