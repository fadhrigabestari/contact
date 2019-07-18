//
//  AddContactViewController+IAddContactView.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 18/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit

extension AddContactViewController: IAddContactView {
    func showSendAddContactSuccess() {
        let alert = UIAlertController(title: "Success!", message: "Contact successfully added", preferredStyle: .alert)
//        alert.setValue(NSAttributedString(string: alert.message!, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedStringKey.foregroundColor : UIColor.green]), forKey: "attributedMessage")
        self.present(alert, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    func showSendAddContactFailed() {
        let alert = UIAlertController(title: "Failed!", message: "Contact failed to be added", preferredStyle: .alert)
//        alert.setValue(NSAttributedString(string: alert.message!, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedStringKey.foregroundColor : "FC100D".toUIColor()]), forKey: "attributedMessage")
        self.present(alert, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
    }
}
