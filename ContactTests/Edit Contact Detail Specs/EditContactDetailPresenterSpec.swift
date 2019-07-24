//
//  EditContactDetailPresenterSpec.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 24/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Contact

class EditContactDetailSpec: QuickSpec {
    var view: MockEditContactDetailView!
    var presenter: EditContactDetailPresenter!
    var interactor: MockEditContactDetailInteractor!
    var wireframe: MockEditContactDetailWireframe!
    var initialUpdatedAt: Date?
    var mockContact = Contact(id: 1, firstName: "test", lastName: "test", email: "test@email.com", profilePic: "not-found", phoneNumber: "123123123", isFavorite: false, url: nil, createdAt: Date(), updatedAt: Date())
    
    override func spec() {
        describe("EditContactDetailPresenter") {
            self.view = MockEditContactDetailView()
            self.interactor = MockEditContactDetailInteractor()
            self.wireframe = MockEditContactDetailWireframe()
            self.presenter = EditContactDetailPresenter(view: self.view, interactor: self.interactor, wireframe: self.wireframe)
            
            context("done button is pressed") {
                self.initialUpdatedAt = self.mockContact.updatedAt
                self.presenter.onDoneButtonPressed(navigationController: UINavigationController(), contact: self.mockContact.toEditContactDetailEntity)
                
                it("should update it's updatedAt property") {
                    expect(self.interactor.contact?.updatedAt).toNot(equal(self.initialUpdatedAt))
                }
                it("should have '+' character as first character for phone number") {
                    expect(self.interactor.contact?.phoneNumber?.first).to(equal("+"))
                }
            }
            
            context("send edited contact detail successful") {
                self.presenter.sendEditedContactDetailSuccess(navigationController: UINavigationController(), contact: self.mockContact)
                it("should call view to show contact detail") {
                    expect(self.view.stubbedShowSendEditContactDetailSuccess).to(beTrue())
                }
                
                it("should call wireframe to pop to contact detail screen") {
                    expect(self.wireframe.isPoppedToContactDetailScreen).to(beTrue())
                }
            }
            
            context("send edited contact detail failed") {
                self.presenter.sendEditedContactDetailFailed()
                it("should call view to show failed contact detail view") {
                    expect(self.view.stubbedShowEditedContactDetailFailed).to(beTrue())
                }
            }
            
            context("cancel button is pressed") {
                self.presenter.onCancelButtonPressed(navigationController: UINavigationController())
                it("should call wireframe to cancel to contact detail screen") {
                    expect(self.wireframe.isCancelledToContactDetailScreen).to(beTrue())
                }
            }
        }
    }
}
