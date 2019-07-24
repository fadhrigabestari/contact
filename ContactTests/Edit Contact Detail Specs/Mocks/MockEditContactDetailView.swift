//
//  MockEditContactDetailView.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 24/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
@testable import Contact

class MockEditContactDetailView: IEditContactDetailView {
    var stubbedShowSendEditContactDetailSuccess = false
    var stubbedShowEditedContactDetailFailed = false
    
    func showSendEditContactDetailSuccess() {
        stubbedShowSendEditContactDetailSuccess = true
    }
    
    func showSendEditedContactDetailFailed() {
        stubbedShowEditedContactDetailFailed = true
    }
}
