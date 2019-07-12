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
    func showEditedContactDetail(contact: EditContactDetailEntity)
    func showSendEditedContactDetailError()
}

protocol IEditContactDetailPresenter: class {
    func onDoneButtonPressed(contact: EditContactDetailEntity)
    func onEditPictureButtonPressed()
    func sendEditedContactDetailSuccess(contact: EditContactDetailEntity)
    func sendEditedContactDetailFailed()
    func onCancelButtonPressed(navigationController: UINavigationController)
}

protocol IEditContactDetailInteractor: class {
    var presenter: IEditContactDetailPresenter? {get set}
    
    func sendEditedContactDetail(contact: EditContactDetailEntity)
}

protocol IEditContactDetailWireframe: class {
    func createModule() -> EditContactDetailViewController
    
    func pushToContactDetailScreen(navigationController: UINavigationController)
}
