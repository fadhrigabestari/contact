//
//  EditContactDetailViewController.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 10/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import UIKit

class EditContactDetailViewController: UIViewController {
    var presenter: IEditContactDetailPresenter?

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var cameraIcon: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupProfilePicture()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    private func setupNavigationBar() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tappedCancelButton))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    private func setupProfilePicture() {
        applyRoundCorner(self.profilePicture)
        applyRoundCorner(self.cameraIcon)
        
        self.profilePicture.layer.borderColor = UIColor.white.cgColor
        self.profilePicture.layer.borderWidth = 3
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "ContactDetailViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EditContactCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    @objc private func tappedCancelButton() {
        self.presenter?.onCancelButtonPressed(navigationController: self.navigationController!)
    }
}

extension EditContactDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditContactCell", for: indexPath) as! ContactDetailViewCell
        
        switch(indexPath.row) {
        default: break
        }
        
        return cell
    }
}
