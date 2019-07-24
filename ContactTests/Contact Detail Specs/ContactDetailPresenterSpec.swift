//
//  ContactDetailPresenterSpec.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 23/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Contact

class ContactDetailPresenterSpec: QuickSpec {
    var view: MockContactDetailView!
    var presenter: ContactDetailPresenter!
    var interactor: MockContactDetailInteractor!
    var wireframe: MockContactDetailWireframe!
    
    override func spec() {
        beforeEach {
            self.view = MockContactDetailView()
            self.interactor = MockContactDetailInteractor()
            self.wireframe = MockContactDetailWireframe()
            self.presenter = ContactDetailPresenter(view: self.view, interactor: self.interactor, wireframe: self.wireframe)
        }
        
        describe("ContactDetailPresenter") {
            context("message button is pressed") {
                it("should call wireframe to push to message screen") {
                    self.presenter.onMessageButtonPressed(number: "123123")
                    expect(self.wireframe.pushToMessageScreenCounter).to(equal(1))
                }
            }
            
            context("on call button is pressed") {
                it("should call wireframe to push to call screen") {
                    self.presenter.onCallButtonPressed(number: "123123")
                    expect(self.wireframe.pushToCallScreenCounter).to(equal(1))
                }
            }
            
            context("on email button is pressed") {
                it("should call wireframe to push to email screen") {
                    self.presenter.onEmailButtonPressed(email: "email@email.com")
                    expect(self.wireframe.pushToEmailScreenCounter).to(equal(1))
                }
            }
            
            context("on favorite button is pressed") {
                it("should call interactor to send contact data to server") {
                    let testContactDetail = ContactDetailEntity(id: 1, firstName: "test", lastName: "test", email: "email@email.com", phoneNumber: "123123123131", profilePic: "not-found", isFavorite: true, createdAt: Date(), updatedAt: Date(), rows: [])
                    self.presenter.onFavoriteButtonPressed(contact: testContactDetail)
                    expect(self.interactor.sendContactDetailCounter).to(equal(1))
                }
            }
            
            context("screen is displayed") {
                it("should call interactor to fetch contact detail data from server") {
                    let testId = 1
                    self.presenter.startFetchingContactDetail(id: testId)
                    expect(self.interactor.fetchContactDetailCounter).to(equal(1))
                }
            }
            
            context("on edit button is pressed") {
                it("should call wireframe to push to edit button") {
                   let navigationController = UINavigationController()
                    let testContactDetail = ContactDetailEntity(id: 1, firstName: "test", lastName: "test", email: "email@email.com", phoneNumber: "123123123131", profilePic: "not-found", isFavorite: true, createdAt: Date(), updatedAt: Date(), rows: [])
                    self.presenter.onEditButtonPressed(navigationController: navigationController, contact: testContactDetail)
                    expect(self.wireframe.pushToEditScreenCounter).to(equal(1))
                }
            }
            
            context("on interactor successfully fetch contact detail") {
                it("should call view to show contact detail") {
                    let testContact = Contact(id: 1, firstName: "test", lastName: "test", email: "test@email.com", profilePic: "not-found", phoneNumber: "123123123", isFavorite: false, url: nil, createdAt: nil, updatedAt: nil)
                    self.presenter.contactDetailFetchSuccess(contact: testContact)
                    expect(self.view.showContactDetailCounter).to(equal(1))
                }
            }
            
            context("on interactor successfully send favorited contact detail") {
                it("should call view to show send contact detail") {
                    let testContact = Contact(id: 1, firstName: "test", lastName: "test", email: "test@email.com", profilePic: "not-found", phoneNumber: "123123123", isFavorite: true, url: nil, createdAt: nil, updatedAt: nil)
                    self.presenter.sendContactDetailSuccess(contact: testContact)
                    expect(self.view.showSendContactDetailSuccessCounter).to(equal(1))
                }
            }
            
            context("on interactor successfully send unfavorited contact detail") {
                it("should not call view to show send contact detail") {
                    let testContact = Contact(id: 1, firstName: "test", lastName: "test", email: "test@email.com", profilePic: "not-found", phoneNumber: "123123123", isFavorite: false, url: nil, createdAt: nil, updatedAt: nil)
                    self.presenter.sendContactDetailSuccess(contact: testContact)
                    expect(self.view.showSendContactDetailSuccessCounter).to(equal(0))
                }
            }
        }
    }
}
