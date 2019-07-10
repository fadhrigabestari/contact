//
//  EditContactDetailWireframe.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 10/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit

class EditContactDetailWireframe: IEditContactDetailWireframe {
    func createModule() -> EditContactDetailViewController {
        let view = EditContactDetailViewController()
        let interactor = EditContactDetailInteractor()
        let wireframe = EditContactDetailWireframe()
        let presenter = EditContactDetailPresenter(view: view, interactor: interactor, wireframe: wireframe)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
    
    func pushToContactDetailScreen() {
        //
    }
}
