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
        assignFunctionToIcon()
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
    
    func assignFunctionToIcon() {
        var tap: UITapGestureRecognizer
        
        tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedMessageIcon))
        messageIcon.addGestureRecognizer(tap)
        messageIcon.isUserInteractionEnabled = true
        
        tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedCallIcon))
        callIcon.addGestureRecognizer(tap)
        callIcon.isUserInteractionEnabled = true
        
        tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedEmailIcon))
        emailIcon.addGestureRecognizer(tap)
        emailIcon.isUserInteractionEnabled = true
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tappedFavoriteIcon))
//        favoriteIcon.addGestureRecognizer(tap)
//        favoriteIcon.isUserInteractionEnabled = true
    }
    
    @objc func tappedMessageIcon() {
        guard let number = contactDetail?.phoneNumber else {
            return
        }
        self.presenter?.onMessageButtonPressed(number: number)
    }
    
    @objc func tappedCallIcon() {
        guard let number = contactDetail?.phoneNumber else {
            return
        }
        self.presenter?.onCallButtonPressed(number: number)
    }
    
    @objc func tappedEmailIcon() {
        guard let email = contactDetail?.email else {
            return
        }
        self.presenter?.onEmailButtonPressed(email: email)
    }
}

extension ContactDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactDetailCell") as! ContactDetailViewCell
        cell.selectionStyle = .none
        
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
