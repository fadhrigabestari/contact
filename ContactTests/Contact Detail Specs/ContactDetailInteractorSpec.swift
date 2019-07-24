//
//  ContactDetailInteractorSpec.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 24/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Contact

class ContactDetailInteractorSpec: QuickSpec {
    var presenter: MockContactDetailPresenter!
    var interactor: ContactDetailInteractor!
    
    override func spec() {
        beforeEach {
            self.presenter = MockContactDetailPresenter()
            self.interactor = ContactDetailInteractor()
            self.interactor.presenter = self.presenter
        }
        
        describe("ContactDetailInteractor") {
            context("contact detail successfully fetched") {
                it("should notify presenter that contact was successfully fetched") {
                    let contactStub = Contact(id: 0,
                                                 firstName: "fadhriga",
                                                 lastName: "bestari",
                                                 email: "fadhriga.bestari@gmail.com",
                                                 profilePic: "not-found",
                                                 phoneNumber: "+123",
                                                 isFavorite: true,
                                                 url: nil,
                                                 createdAt: Date(),
                                                 updatedAt: Date())
                    self.interactor.presenter?.contactDetailFetchSuccess(contact: contactStub)
                    expect(self.presenter.contactDetailFetchSuccessCounter).to(equal(1))
                }
            }
            
            context("contact detail failed to be fetched") {
                it("should notify presenter that contact was unsuccessfully fetched") {
                    self.interactor.presenter?.contactDetailFetchFailed()
                    expect(self.presenter.contactDetailFetchFailedCounter).to(equal(1))
                }
            }
            
            context("contact detail successfully sent") {
                it("should notify presenter that contact was sent successfully") {
                    let contactStub = Contact(id: 0,
                                              firstName: "fadhriga",
                                              lastName: "bestari",
                                              email: "fadhriga.bestari@gmail.com",
                                              profilePic: "not-found",
                                              phoneNumber: "+123",
                                              isFavorite: true,
                                              url: nil,
                                              createdAt: Date(),
                                              updatedAt: Date())
                    self.interactor.presenter?.contactDetailFetchSuccess(contact: contactStub)
                    expect(self.presenter.contactDetailFetchSuccessCounter).to(equal(1))
                }
            }
            
            context("contact detail failed to be sent") {
                it("should notify presenter that contact was sent unsuccessfully") {
                    self.interactor.presenter?.sendContactDetailFailed()
                    expect(self.presenter.sendContactDetailFailedCounter).to(equal(1))
                }
            }
        }
    }
}

extension ContactDetailInteractorSpec {
    class MockContactDetailPresenter: IContactDetailPresenter {
        var contactDetailFetchSuccessCounter = 0
        var contactDetailFetchFailedCounter = 0
        var sendContactDetailSuccessCounter = 0
        var sendContactDetailFailedCounter = 0
        
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
            contactDetailFetchFailedCounter += 1
        }
        
        func sendContactDetailSuccess(contact: Contact) {
            sendContactDetailSuccessCounter += 1
        }
        
        func sendContactDetailFailed() {
            sendContactDetailFailedCounter += 1
        }
    }
}
