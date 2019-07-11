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
    
    var contact: EditContactDetailEntity?
    typealias RowItem = (category: String, value: String, placeholder: String)
    var rows = [RowItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupProfilePicture()
        setupTableView()
        // Do any additional setup after loading the view.
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        tableView.separatorInset = UIEdgeInsetsMake(0, UIScreen.main.bounds.width, 0, 0)
    }
    
    private func setupNavigationBar() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tappedCancelButton))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    private func setupProfilePicture() {
        guard let profilePic = contact?.profilePic else {
            return
        }
        
        if profilePic.isValidURL {
            self.profilePicture.load(url: URL(string: profilePic)!)
        } else {
            self.profilePicture.image = UIImage(named: "default-contact-image")
        }
        applyRoundCorner(self.profilePicture)
        applyRoundCorner(self.cameraIcon)
        
        self.profilePicture.layer.borderColor = UIColor.white.cgColor
        self.profilePicture.layer.borderWidth = 3
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "EditContactDetailViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "EditContactCell")
        
        tableView.isScrollEnabled = false
        tableView.separatorInset = UIEdgeInsetsMake(0, UIScreen.main.bounds.width, 0, 0)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 54
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    @objc private func tappedCancelButton() {
        self.presenter?.onCancelButtonPressed(navigationController: self.navigationController!)
    }
}

extension EditContactDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditContactCell", for: indexPath) as! EditContactDetailViewCell
        cell.selectionStyle = .none
        
        cell.category.text = rows[indexPath.row].category
        cell.textField.text = rows[indexPath.row].value
        cell.textField.placeholder = rows[indexPath.row].placeholder
        
        return cell
    }
}
