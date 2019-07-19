//
//  EditContactDetailViewController+IEditContactDetailView.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 10/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit

extension EditContactDetailViewController: IEditContactDetailView {
    func showSendEditContactDetailSuccess() {
//        let alert = UIAlertController(title: "Success!", message: "Contact detail successfully changed", preferredStyle: .alert)
//        alert.setValue(NSAttributedString(string: alert.message!, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedStringKey.foregroundColor : UIColor.green]), forKey: "attributedMessage")
//        self.present(alert, animated: true, completion: nil)
//
//        let when = DispatchTime.now() + 1
//        DispatchQueue.main.asyncAfter(deadline: when){
//            alert.dismiss(animated: true, completion: nil)
//        }
        self.progressHUD.hide()
    }
    
    func showSendEditedContactDetailFailed() {
        let alert = UIAlertController(title: "Failed!", message: "Contact detail failed to be changed", preferredStyle: .alert)
//        alert.setValue(NSAttributedString(string: alert.message!, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.medium), NSAttributedStringKey.foregroundColor : "FC100D".toUIColor()]), forKey: "attributedMessage")
        self.present(alert, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when){
            alert.dismiss(animated: true, completion: nil)
        }
    }
}
