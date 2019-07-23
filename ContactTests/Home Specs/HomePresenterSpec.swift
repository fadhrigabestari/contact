//
//  HomeSpec.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 22/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Contact

class HomePresenterSpec: QuickSpec {
    var view: MockHomeView!
    var presenter: IHomePresenter!
    var interactor: MockHomeInteractor!
    var wireframe: MockHomeWireframe!
    
    override func spec() {
        describe("HomePresenter") {
            view = MockHomeView()
            interactor = MockHomeInteractor()
            wireframe = MockHomeWireframe()
            presenter = HomePresenter(view: view, interactor: interactor, wireframe: wireframe)
            
            context("called to fetch contacts") {
                it("should call interactor to fetch contacts") {
                    self.presenter.startFetchingContacts()
                    expect(self.interactor.fetchContactsCounter).to(equal(1))
                }
            }
            
            context("add button is pressed") {
                it("should call wireframe to push to add screen") {
                    self.presenter.onAddButtonPressed(navigationController: UINavigationController())
                    expect(self.wireframe.pushToAddScreenCounter).to(equal(1))
                }
            }
            
            context("cell in table view is pressed") {
                it("should call wireframe to push to contact detail screen") {
                    let testId = 14
                    self.presenter.onContactsCellPressed(navigationController: UINavigationController(), id: testId)
                    expect(self.wireframe.pushToContactDetailScreen).to(equal(1))
                    expect(self.wireframe.id).to(equal(testId))
                }
            }
            
            context("has a list of Contact model") {
                let contactStubOne = Contact(id: 0,
                                             firstName: "fadhriga",
                                             lastName: "bestari",
                                             email: "fadhriga.bestari@gmail.com",
                                             profilePic: "not-found",
                                             phoneNumber: "+123",
                                             isFavorite: true,
                                             url: nil,
                                             createdAt: Date(),
                                             updatedAt: Date())
                let contactStubTwo = Contact(id: 1,
                                             firstName: "wawa",
                                             lastName: "hehoh",
                                             email: "wawa.hehoh@e.co",
                                             profilePic: "yes-found",
                                             phoneNumber: "+321",
                                             isFavorite: false,
                                             url: "wawahehoh.com",
                                             createdAt: nil,
                                             updatedAt: nil)
                self.presenter.contacts = [contactStubOne, contactStubTwo]
                
                it("should be able to map Contact based on its first character") {
                    let contactCollection = self.presenter.filterContacts(contacts: self.presenter.contacts)
                    expect(contactCollection[0].sectionName).to(equal("Favorite"))
                    expect(contactCollection[1].sectionName).to(equal("W"))
                    expect(contactCollection[0].contacts.first?.id).to(equal(contactStubOne.id))
                    expect(contactCollection[1].contacts.first?.id).to(equal(contactStubTwo.id))
                }
            }
            
            context("fetch contact is successful") {
                let contactCollection = self.presenter.filterContacts(contacts: self.presenter.contacts)
                
                it("should call view to show contacts") {
                    self.view.showContacts(contacts: contactCollection)
                    expect(self.view.showContactsCounter).to(equal(1))
                }
            }
        }
    }
}

extension HomePresenterSpec {
    class MockHomeView: IHomeView {
        var showContactsCounter = 0
        
        func showContacts(contacts: [ContactCollection]) {
            self.showContactsCounter += 1
        }
    }
    
    class MockHomeInteractor: IHomeInteractor {
        var presenter: IHomePresenter?
        var fetchContactsCounter = 0
        
        func fetchContacts() {
            self.fetchContactsCounter += 1
        }
    }
    
    class MockHomeWireframe: IHomeWireframe {
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
}
