//
//  EditContactDetailTableViewCell.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 11/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import UIKit

class EditContactDetailViewCell: UITableViewCell {

    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var textField: UITextField!
    var textFieldDelegate: UITextFieldDelegate! {
        didSet {
            self.textField.delegate = self.textFieldDelegate
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.separatorInset.left = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
