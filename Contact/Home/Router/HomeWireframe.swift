//
//  HomeWireframe.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 05/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit

class HomeWireframe: HomePresenterToWireframeProtocol {
    internal func createModule() -> HomeViewController {
        let view = HomeViewController(nibName: "HomeViewController", bundle: nil)
        let interactor = HomeInteractor()
        let presenter = HomePresenter(view: view, interactor: interactor, wireframe: self)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
    
    func pushToAddScreen(navigationController: UINavigationController) {
//        let addModule = AddWireframe.createModule()
//        navigationController.pushViewController(addModule, animated: true)
    }
    
    func pushToGroupsScreen(navigationController: UINavigationController) {
//        let groupsModule = GroupsWireframe.createModule()
//        navigationController.pushViewController(groupsModule, animated: true)
    }
    
    func pushToContactDetailScreen(navigationController: UINavigationController, id: Int) {
        let contactDetailWireframe = ContactDetailWireframe()
        let contactDetailModule = contactDetailWireframe.createModule()
        contactDetailModule.id = id
        navigationController.pushViewController(contactDetailModule, animated: true)
    }
}
