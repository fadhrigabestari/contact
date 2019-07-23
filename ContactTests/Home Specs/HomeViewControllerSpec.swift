//
//  HomeViewControllerSpec.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 23/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Contact

//class HomeViewControllerSpec: QuickSpec {
//    var view: HomeViewController!
//    var presenter: MockHomePresenter!
//
//    override func spec() {
//        self.view = HomeViewController()
//        self.presenter = MockHomePresenter()
//        self.view.presenter = self.presenter
//
//        describe("HomeViewController") {
//            context("when contacts need to be shown") {
//                it("should show contacts") {
//                    let contactStubOne = Contact(id: 0,
//                                                 firstName: "fadhriga",
//                                                 lastName: "bestari",
//                                                 email: "fadhriga.bestari@gmail.com",
//                                                 profilePic: "not-found",
//                                                 phoneNumber: "+123",
//                                                 isFavorite: true,
//                                                 url: nil,
//                                                 createdAt: Date(),
//                                                 updatedAt: Date())
//                    let contactStubTwo = Contact(id: 1,
//                                                 firstName: "wawa",
//                                                 lastName: "hehoh",
//                                                 email: "wawa.hehoh@e.co",
//                                                 profilePic: "yes-found",
//                                                 phoneNumber: "+321",
//                                                 isFavorite: false,
//                                                 url: "wawahehoh.com",
//                                                 createdAt: nil,
//                                                 updatedAt: nil)
//                    let contactCollection = [ContactCollection(sectionName: "F", contacts: [contactStubOne.toContactEntity]), ContactCollection(sectionName: "W", contacts: [contactStubTwo.toContactEntity])]
//
//                    self.view.showContacts(contacts: contactCollection)
//                    expect(self.view.contactCollection).to(equal(contactCollection))
//                }
//            }
//        }
//    }
//}
//
//extension HomeViewControllerSpec {
//    class MockHomePresenter: IHomePresenter {
//        var contacts: [Contact] = []
//        var startFetchingContactsCounter = 0
//        var onAddButtonPressedCounter = 0
//        var onGroupsButtonPressedCounter = 0
//        var onContactsCellPressedCounter = 0
//        var onContactsFetchSuccessCounter = 0
//        var onContactsFetchFailedCounter = 0
//        var FilterContactsCounter = 0
//
//        func startFetchingContacts() {
//            startFetchingContactsCounter += 1
//        }
//
//        func onAddButtonPressed(navigationController: UINavigationController) {
//            onAddButtonPressedCounter += 1
//        }
//
//        func onGroupsButtonPressed(navigationController: UINavigationController) {
//            onGroupsButtonPressedCounter += 1
//        }
//
//        func onContactsCellPressed(navigationController: UINavigationController, id: Int) {
//            onContactsCellPressedCounter += 1
//        }
//
//        func contactsFetchSuccess(contacts: [Contact]) {
//            self.contacts = contacts
//            onContactsFetchSuccessCounter += 1
//        }
//
//        func contactsFetchFailed() {
//            onContactsFetchFailedCounter += 1
//        }
//
//        func filterContacts(contacts: [Contact]) -> [ContactCollection] {
//            FilterContactsCounter += 1
//            return [ContactCollection(sectionName: "test", contacts: [contacts.first!.toContactEntity])]
//        }
//    }
//}
