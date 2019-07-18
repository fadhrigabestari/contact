//
//  EditContactDetailContracts.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 10/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit

protocol IEditContactDetailView: class {
    func showSendEditContactDetailSuccess()
    func showSendEditedContactDetailFailed()
}

protocol IEditContactDetailPresenter: class {
    func onDoneButtonPressed(navigationController: UINavigationController, contact: EditContactDetailEntity)
    func onEditPictureButtonPressed()
    func sendEditedContactDetailSuccess(navigationController: UINavigationController, contact: Contact)
    func sendEditedContactDetailFailed()
    func onCancelButtonPressed(navigationController: UINavigationController)
}

protocol IEditContactDetailInteractor: class {
    var presenter: IEditContactDetailPresenter? {get set}
    
    func sendEditedContactDetail(navigationController: UINavigationController, contact: Contact)
}

protocol IEditContactDetailWireframe: class {
    func createModule(delegate: ContactDetailDelegate) -> EditContactDetailViewController
    
    func pushToContactDetailScreen(navigationController: UINavigationController, contact: Contact)
    func cancelToContactDetailScreen(navigationController: UINavigationController)
}
