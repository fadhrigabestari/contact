//
//  HomeInteractorSpec.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 23/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Contact

class HomeInteractorSpec: QuickSpec {
    var presenter: MockHomePresenter!
    var interactor: HomeInteractor!
    
    override func spec() {
        presenter = MockHomePresenter()
        interactor = HomeInteractor()
        interactor.presenter = presenter
        
        describe("HomeInteractor") {
            context("fetch contact successful") {
                it("should notify presenter fetch successful") {
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
                    self.interactor.presenter?.contactsFetchSuccess(contacts: [contactStubOne, contactStubTwo])
                    expect(self.presenter.onContactsFetchSuccessCounter).to(equal(1))
                }
                
                context("fetch contacts failed") {
                    it("should notify presenter fetch failed") {
                        self.interactor.presenter?.contactsFetchFailed()
                        expect(self.presenter.onContactsFetchFailedCounter).to(equal(1))
                    }
                }
            }
        }
    }
}
