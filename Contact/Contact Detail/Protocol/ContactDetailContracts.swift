//
//  ContactDetailProtocol.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 08/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit

protocol IContactDetailView {
    func showContactDetail(contactDetail: ContactDetailView)
}

protocol IContactDetailPresenter {
    func onMessageButtonPressed(navigationController: UINavigationController)
    func onCallButtonPressed(navigationController: UINavigationController)
    func onEmailButtonPressed(navigationController: UINavigationController)
    func onFavoriteButtonPressed(navigationController: UINavigationController)
    func onBackButtonPressed(navigationController: UINavigationController)
    func onEditButtonPressed(navigationController: UINavigationController)
    func startFetchingContactDetail(id: Int)
    func contactDetailFetchSuccess(contactDetail: ContactDetail)
}

protocol IContactDetailInteractor {
    var preseter: IContactDetailPresenter? {get set}
    
    func fetchContactDetail(id: Int)
}

protocol IContactDetailWireframe {
    func createModule() -> ContactDetailViewController
    func pushToMessageScreen(navigationController: UINavigationController)
    func pushToCallScreen(navigationController: UINavigationController)
    func pushToEmailScreen(navigationController: UINavigationController)
    func pushToHomeScreen(navigationController: UINavigationController)
    func pushToEditScreen(navigationController: UINavigationController)
}
