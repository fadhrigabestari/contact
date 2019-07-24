//
//  HomeWireframeSpec.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 23/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Contact

class HomeWireframeSpec: QuickSpec {
    var presenter: IHomePresenter!
    var wireframe: HomeWireframe!
    
    override func spec() {
        beforeEach {
            self.wireframe = HomeWireframe()
            self.presenter = MockHomePresenter()
            self.wireframe.presenter = self.presenter
        }
        
        describe("HomeWireframe") {
            context("called to create module") {
                it("should return proper HomeViewController") {
                    let view = self.wireframe.createModule()
                    expect(view).to(beAnInstanceOf(HomeViewController.self))
                    expect(view.presenter).toNot(beNil())
                }
            }
            
            context("called to push to add screen") {
                it("should push view controller to said module") {
                    let navigationController = UINavigationController()
                    self.wireframe.pushToAddScreen(navigationController: navigationController)
                    expect(navigationController.topViewController).to(beAnInstanceOf(AddContactViewController.self))
                }
            }
            
            context("called to push to contact detail") {
                it("should push view controller to said module") {
                    let navigationController = UINavigationController()
                    let testId = 14
                    self.wireframe.pushToContactDetailScreen(navigationController: navigationController, id: testId)
                    expect(navigationController.topViewController).to(beAnInstanceOf(ContactDetailViewController.self))
                    if let contactDetailViewController = navigationController.topViewController as? ContactDetailViewController {
                        expect(contactDetailViewController.id).to(equal(testId))
                    }
                }
            }
            
            context("contact was added") {
                it("should append contact to presenter") {
                    let testContact = Contact(id: 0,
                                              firstName: "test",
                                              lastName: "testing",
                                              email: "test@email.com",
                                              profilePic: "not-found",
                                              phoneNumber: "123123",
                                              isFavorite: false,
                                              url: nil,
                                              createdAt: Date(),
                                              updatedAt: Date())
                    self.wireframe.onContactAdded(contact: testContact)
                    expect(self.presenter.contacts).to(equal([testContact]))
                }
            }
        }
    }
}
