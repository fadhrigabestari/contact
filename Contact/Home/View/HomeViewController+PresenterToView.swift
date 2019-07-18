//
//  HomeViewController+PresenterToView.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 08/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation

extension HomeViewController: IHomeView {
    func showContacts(contacts: [ContactCollection]) {
        self.contactCollection = contacts
        self.tableView.reloadData()
    }
}
