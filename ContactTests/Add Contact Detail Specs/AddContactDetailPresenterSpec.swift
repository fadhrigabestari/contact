//
//  AddContactDetailSpec.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 24/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Contact

class AddContactDetailPresenterSpec: QuickSpec {
    var view: MockAddContactDetailView!
    var presenter: AddContactPresenter!
    var interactor: MockAddContactDetailInteractor!
    var wireframe: MockAddContactDetailWireframe!
    var mockContact = Contact(id: 1, firstName: "test", lastName: "test", email: "test@email.com", profilePic: "not-found", phoneNumber: "123123123", isFavorite: false, url: nil, createdAt: Date(), updatedAt: Date())
    
    override func spec() {
        describe("AddContactDetailPresenter") {
            self.view = MockAddContactDetailView()
            self.interactor = MockAddContactDetailInteractor()
            self.wireframe = MockAddContactDetailWireframe()
            self.presenter = AddContactPresenter(view: view, interactor: interactor, wireframe: wireframe)
            context("done button is pressed") {
               self.interactor.isAddContactSent = false
                self.presenter.onDoneButtonPressed(navigationController: UINavigationController(), contact: mockContact.toAddContactEntity)
                it("should call interactor to send contact detail") {
                    expect(self.interactor.isAddContactSent).to(beTrue())
                }
            }
            
            context("cancel button is pressed") {
               self.wireframe.isCancelledToHomeScreen = false
                self.presenter.onCancelButtonPressed(navigationController: UINavigationController())
                it("should call wireframe to cancel to home screen") {
                    expect(self.wireframe.isCancelledToHomeScreen).to(beTrue())
                }
            }
            
            context("interactor successfully send contact details") {
                self.wireframe.isPoppedToHomeScreen = false
                self.presenter.sendAddContactSuccess(navigationController: UINavigationController(), contact: mockContact)
                it("should call wireframe to pop to home screen") {
                    expect(self.wireframe.isPoppedToHomeScreen).to(beTrue())
                }
            }
            
            context("interactor failed to send contact details") {
                self.view.isSendAddContactFailedShown = false
                self.presenter.sendAddContactFailed()
                it("should call view to show failed send contact view") {
                    expect(self.view.isSendAddContactFailedShown).to(beTrue())
                }
            }
        }
    }
}
