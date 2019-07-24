//
//  EditContactDetailInteractorSpec.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 24/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Contact

class EditContactDetailInteractorSpec: QuickSpec {
    var presenter: MockEditContactDetailPresenter!
    var interactor: EditContactDetailInteractor!
    
    override func spec() {
        describe("EditContactDetailInteractor") {
            self.presenter = MockEditContactDetailPresenter()
            self.interactor = EditContactDetailInteractor()
            self.interactor.presenter = self.presenter
            context("") {
                
            }
        }
    }
}
