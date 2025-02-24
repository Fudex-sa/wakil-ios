//
//  GuardRequired.swift
//  BaseIOS
//
//  Created by Mabdu on 06/06/2021.
//  Copyright © 2021 com.mabdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  Guard required
internal struct GuardEmailOrPhone: Guard {
    
    // MARK: - ...  vars
    var textField: UITextField!

    // MARK: - ... functions
    func confirm() -> Bool {
        if textField.text?.isNumeric == true {
            return GuardPhone(textField: textField).confirm()
        } else {
            return GuardEmail(textField: textField).confirm()
        }
    }
    func errorMessage(_ field: String?) -> String? {
        if textField.text?.isNumeric == true {
            return GuardPhone(textField: textField).errorMessage(field)
        } else {
            return GuardEmail(textField: textField).errorMessage(field)
        }
    }
}
