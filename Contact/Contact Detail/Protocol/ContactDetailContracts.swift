//
//  ContactDetailProtocol.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 08/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit

protocol IContactDetailView: class {
    func showContactDetail(contact: ContactDetailEntity)
}

protocol IContactDetailPresenter: class {
    func onMessageButtonPressed(number: String)
    func onCallButtonPressed(number: String)
    func onEmailButtonPressed(email: String)
    func onFavoriteButtonPressed(navigationController: UINavigationController)
    func onEditButtonPressed(navigationController: UINavigationController, contact: ContactDetailEntity)
    func startFetchingContactDetail(id: Int)
    func contactDetailFetchSuccess(contact: ContactDetail)
    func contactDetailFetchFailed()
}

protocol IContactDetailInteractor: class {
    var presenter: IContactDetailPresenter? {get set}
    
    func fetchContactDetail(id: Int)
}

protocol IContactDetailWireframe: class {
    func createModule() -> ContactDetailViewController
    func pushToMessageScreen(number: String)
    func pushToCallScreen(number: String)
    func pushToEmailScreen(email: String)
    func pushToEditScreen(navigationController: UINavigationController, contact: ContactDetailEntity)
}
