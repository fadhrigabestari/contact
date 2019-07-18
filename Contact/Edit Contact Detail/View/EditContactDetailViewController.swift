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
    var imagePicker = UIImagePickerController()

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var cameraIcon: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var contact: EditContactDetailEntity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupProfilePicture()
        setupTableView()
        setupNotificationCenter()
        setupTapRecognizer()
        setupImagePicker()
        // Do any additional setup after loading the view.
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        tableView.separatorInset = UIEdgeInsetsMake(0, UIScreen.main.bounds.width, 0, 0)
    }
    
    private func setupNavigationBar() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(tappedCancelButton))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(tappedDoneButton))
        doneButton.isEnabled = contact.email.isValidEmail && contact.phoneNumber.isValidPhone
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
    
    @objc func tappedCancelButton() {
        self.presenter?.onCancelButtonPressed(navigationController: self.navigationController!)
    }
    
    @objc func tappedDoneButton() {
        self.presenter?.onDoneButtonPressed(navigationController: self.navigationController!, contact: contact)
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }

        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardFrame.height
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        guard let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y += keyboardFrame.height
        }
    }
    
    private func setupTapRecognizer() {
        var tap: UITapGestureRecognizer
        
        tap = UITapGestureRecognizer(target: self, action: #selector(tappedView))
        view.addGestureRecognizer(tap)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(tappedCameraIcon))
        cameraIcon.addGestureRecognizer(tap)
        
    }
    
    @objc func tappedView() {
        view.endEditing(true)
    }
    
    @objc func tappedCameraIcon(_ sender: UIView) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender
            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
}

extension EditContactDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contact.rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditContactCell", for: indexPath) as! EditContactDetailViewCell
        cell.selectionStyle = .none
        
        cell.textField.tag = indexPath.row
        cell.category.text = contact.rows[indexPath.row].category
        cell.textField.text = contact.rows[indexPath.row].value
        cell.textField.placeholder = contact.rows[indexPath.row].placeholder
        cell.textFieldDelegate = self
        
        return cell
    }
}

extension EditContactDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = tableView.viewWithTag(textField.tag + 1) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        switch(textField.tag) {
        case 0:
            contact.firstName = updatedString ?? ""
            break
        case 1:
            contact.lastName = updatedString ?? ""
            break
        case 2:
            contact.phoneNumber = updatedString ?? ""
            break
        case 3:
            contact.email = updatedString ?? ""
            break
        default: break
        }
        
        if contact.email.isValidEmail && contact.phoneNumber.isValidPhone {
            self.navigationItem.rightBarButtonItem!.isEnabled = true
        } else {
            self.navigationItem.rightBarButtonItem!.isEnabled = false
        }
        
        return true
    }
}

extension EditContactDetailViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func setupImagePicker() {
        imagePicker.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            profilePicture.contentMode = .scaleAspectFit
            profilePicture.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
