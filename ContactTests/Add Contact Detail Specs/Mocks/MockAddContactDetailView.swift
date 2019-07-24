//
//  MockAddContactDetailView.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 24/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
@testable import Contact

class MockAddContactDetailView: IAddContactView {
    var isSendAddContactSuccessShown = false
    func showSendAddContactSuccess() {
        self.isSendAddContactSuccessShown = true
    }
    
    var isSendAddContactFailedShown = false
    func showSendAddContactFailed() {
        self.isSendAddContactFailedShown = true
    }
}
