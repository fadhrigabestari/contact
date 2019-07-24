//
//  ContactDetailWireframeSpec.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 24/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Contact

class ContactDetailWireframeSpec: QuickSpec {
    var presenter: IContactDetailPresenter!
    var wireframe: ContactDetailWireframe!
    
    override func spec() {
        beforeEach {
            self.wireframe = ContactDetailWireframe()
            self.presenter = MockContactDetailPresenter()
            self.wireframe.presenter = self.presenter
        }
        
        describe("ContactDetailWireframe") {
            context("called to create module") {
                it("should return proper ContactDetailViewController") {
                    let view = self.wireframe.createModule()
                    expect(view).to(beAnInstanceOf(ContactDetailViewController.self))
                    expect(view.presenter).toNot(beNil())
                }
            }
            
            context("called to push to edit screen") {
                it("should push to edit screen") {
                    let navigationController = UINavigationController()
                    let testContactDetail = ContactDetailEntity(id: 1, firstName: "test", lastName: "test", email: "email@email.com", phoneNumber: "123123123131", profilePic: "not-found", isFavorite: true, createdAt: Date(), updatedAt: Date(), rows: [])
                    self.wireframe.pushToEditScreen(navigationController: navigationController, contact: testContactDetail)
                    expect(navigationController.topViewController).to(beAnInstanceOf(EditContactDetailViewController.self))
                }
            }
            
            context("contact was edited") {
                it("should call presenter that contact was successfully fetched") {
                    let testContact = Contact(id: 1, firstName: "test", lastName: "test", email: "test@email.com", profilePic: "not-found", phoneNumber: "123123123", isFavorite: false, url: nil, createdAt: nil, updatedAt: nil)
                    self.wireframe.onContactEditted(contact: testContact)
                    let mock = self.presenter as! MockContactDetailPresenter
                    expect(mock.contactDetailFetchSuccessCounter).to(equal(1))
                }
            }
        }
    }
}

extension ContactDetailWireframeSpec {
    class MockContactDetailPresenter: IContactDetailPresenter {
        var contactDetailFetchSuccessCounter = 0
        
        func onMessageButtonPressed(number: String) {
            //
        }
        
        func onCallButtonPressed(number: String) {
            //
        }
        
        func onEmailButtonPressed(email: String) {
            //
        }
        
        func onFavoriteButtonPressed(contact: ContactDetailEntity) {
            //
        }
        
        func onEditButtonPressed(navigationController: UINavigationController, contact: ContactDetailEntity) {
            //
        }
        
        func startFetchingContactDetail(id: Int) {
            //
        }
        
        func contactDetailFetchSuccess(contact: Contact) {
            contactDetailFetchSuccessCounter += 1
        }
        
        func contactDetailFetchFailed() {
            //
        }
        
        func sendContactDetailSuccess(contact: Contact) {
            //
        }
        
        func sendContactDetailFailed() {
            //
        }
    }
}
