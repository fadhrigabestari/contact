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
    func showEditedProfilePicture()
    func showSendEditedContactDetailError()
    func showEditContactDetailSuccess()
}

protocol IEditContactDetailPresenter: class {
    func onDoneButtonPressed(navigationController: UINavigationController, contact: EditContactDetailEntity)
    func onEditPictureButtonPressed()
    func sendEditedContactDetailSuccess(contact: Contact)
    func sendEditedContactDetailFailed()
    func onCancelButtonPressed(navigationController: UINavigationController)
}

protocol IEditContactDetailInteractor: class {
    var presenter: IEditContactDetailPresenter? {get set}
    
    func sendEditedContactDetail(contact: Contact)
}

protocol IEditContactDetailWireframe: class {
    func createModule() -> EditContactDetailViewController
    
    func pushToContactDetailScreen(navigationController: UINavigationController, contact: EditContactDetailEntity)
    func cancelToContactDetailScreen(navigationController: UINavigationController)
}
