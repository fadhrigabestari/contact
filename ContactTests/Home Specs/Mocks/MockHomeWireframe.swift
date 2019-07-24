//
//  MockHomeWireframe.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 24/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit
@testable import Contact

class MockHomeWireframe: IHomeWireframe {
    var presenter: IHomePresenter?
    
    var createModuleCounter = 0
    var pushToAddScreenCounter = 0
    var pushToGroupsScreenCounter = 0
    var pushToContactDetailScreen = 0
    var id: Int? = nil
    
    func createModule() -> HomeViewController {
        return HomeViewController()
    }
    
    func pushToAddScreen(navigationController: UINavigationController) {
        self.pushToAddScreenCounter += 1
    }
    
    func pushToGroupsScreen(navigationController: UINavigationController) {
        self.pushToGroupsScreenCounter += 1
    }
    
    func pushToContactDetailScreen(navigationController: UINavigationController, id: Int) {
        self.pushToContactDetailScreen += 1
        self.id = id
    }
}
