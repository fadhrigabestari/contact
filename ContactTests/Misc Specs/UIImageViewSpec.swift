//
//  UIImageViewSpec.swift
//  ContactTests
//
//  Created by PT. GOJEK INDONESIA on 24/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Contact

class StringSpec: QuickSpec {
    var string: String!
    
    override func spec() {
        describe("String") {
            context("is an URL") {
                it("isValidURL should return true") {
                   self.string = "https://contacts-app.s3-ap-southeast-1.amazonaws.com/contacts/profile_pics/000/007/926/original/profile_pic.jpg?1563951513"
                    expect(self.string.isValidURL).to(beTrue())
                }
            }
            
            context("is not an URL") {
                it("isValidURL should return false") {
                    self.string = "testing"
                    expect(self.string.isValidURL).to(beFalse())
                }
            }
            
            context("is a hex code") {
                it("should return a UIColor") {
                    self.string = "#FFFFFF"
                    let color = self.string.toUIColor()
                    expect(color.cgColor.components).to(equal([1.0, 1.0, 1.0, 1.0]))
                }
            }
            
            context("is an invalid hex code") {
                it("should return a gray color") {
                    self.string = "white color"
                    expect(self.string.toUIColor()).to(equal(UIColor.gray))
                }
            }
            
            context("is a valid name") {
                it("isValidName should return true") {
                    self.string = "WkadwM&^  %MMi2923"
                    expect(self.string.isValidName).to(beTrue())
                }
            }
            
            context("is not a valid name") {
                it("isValidName should return false") {
                    self.string = ""
                    expect(self.string.isValidName).to(beFalse())
                }
            }
            
            context("is a valid email") {
                it("isValidEmail should return true") {
                    self.string = "fadh@email.com"
                    expect(self.string.isValidEmail).to(beTrue())
                }
            }
            
            context("is not a valid email") {
                it("isValidEmail should return false") {
                    self.string = "fadh@@@aaa"
                    expect(self.string.isValidEmail).to(beFalse())
                }
            }
            
            context("is a valid phone") {
                it("isValidPhone should return true") {
                    self.string = "+6281340952530"
                    expect(self.string.isValidPhone).to(beTrue())
                }
            }
            
            context("is not a valid phone") {
                it("isValidEmail should return false") {
                    self.string = "+123"
                    expect(self.string.isValidEmail).to(beFalse())
                }
            }
        }
    }
}
