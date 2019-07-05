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
    static func createModule() -> HomeViewController {
        let view = HomeViewController(nibName: "HomeViewController", bundle: nil)
        
        let presenter: HomeViewToPresenterProtocol & HomeInteractorToPresenterProtocol = HomePresenter()
        let interactor: HomePresenterToInteractorProtocol = HomeInteractor()
        let wireframe: HomePresenterToWireframeProtocol = HomeWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireframe = wireframe
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
    
    func pushToContactDetailScreen(navigationController: UINavigationController) {
//        let contactDetailModule = ContactDetailWireframe.createModule()
//        navigationController.pushViewController(contactDetailModule, animated: true)
    }
}
