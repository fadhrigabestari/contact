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

    @IBOutlet weak var contactTableView: UITableView!
    var contacts: [Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ContactViewCell", bundle: nil)
        self.contactTableView.register(nib, forCellReuseIdentifier: "ContactCell")
        contactTableView.dataSource = self
        contactTableView.delegate = self

        fetchAllContacts { (contacts) in
            if let arrContact = contacts {
                self.contacts = arrContact
                self.contactTableView.reloadData()
            }
        }
        
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
        cell.contactImage.load(url: contact.profilePic)
        cell.contactName.text = "\(contact.firstName) \(contact.lastName)"
        if contact.isFavorite {
            cell.contactFavourite.text = "⭑"
        } else {
            cell.contactFavourite.text = ""
        }
        cell.selectionStyle = .none
        return cell
    }
}
