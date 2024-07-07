//
//  GuardRequired.swift
//  BaseIOS
//
//  Created by Mabdu on 06/06/2021.
//  Copyright © 2021 com.mabdu. All rights reserved.
//

import Foundation
import UIKit


// MARK: - ...  Guard email
internal struct GuardEmail: Guard {
    
    // MARK: - ...  vars
    var textField: UITextField!
    
    
    // MARK: - ...  functions
    func confirm() -> Bool {
        guard textField.text?.isEmail == true else {
            return false
        }
        if textField.text?.contains("@test.com") == true {
            return false
        }
        return true
    }
    func errorMessage(_ field: String?) -> String? {
        return "\(field ?? "") \("is incorrect email".localized)"
    }
}
