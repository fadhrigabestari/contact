//
//  RoundObject.swift
//  Contact
//
//  Created by PT. GOJEK INDONESIA on 09/07/19.
//  Copyright © 2019 PT. GOJEK INDONESIA. All rights reserved.
//

import Foundation
import UIKit

func applyRoundCorner(_ object: AnyObject) {
    object.layer.cornerRadius = object.frame.width / 2
    object.layer.masksToBounds = true
}
