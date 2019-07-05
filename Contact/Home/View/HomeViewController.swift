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

//        fetchAllContacts { (contacts) in
//            if let arrContact = contacts {
//                self.contacts = arrContact
//                self.contactTableView.reloadData()
//            }
//        }
        
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func fetchAllContacts(completion: @escaping ([Contact]?) -> Void) {
        guard let url = URL(string: "http://gojek-contacts-app.herokuapp.com/contacts.json") else {
            completion(nil)
            return
        }
        
        Alamofire.request(url,
                          method: .get)
        .validate()
        .responseJSON {
            response in guard response.result.isSuccess else {
                print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                completion(nil)
                return
            }
            
            guard let contacts = response.data else {
                print("Malformed data received from FetchAllContacts service")
                completion(nil)
                return
            }
            
            do {
                let contactsDecoded = try JSONDecoder().decode([Contact].self, from: contacts)
                completion(contactsDecoded)
                return
            } catch {
                print(error)
                completion(nil)
                return
            }
        }
    }

}

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

extension HomeViewController: HomePresenterToViewProtocol {
    func showContacts(contacts: [Contact]) {
        self.contacts = contacts
        self.contactTableView.reloadData()
    }
}