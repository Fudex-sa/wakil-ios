//
//  GuardPassword.swift
//  Wndo
//
//  Created by Adam on 20/12/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit


// MARK: - ...  Guard email
internal struct GuardPassword: Guard {
    
    // MARK: - ...  vars
    var textField: UITextField!
    
    
    // MARK: - ...  functions
    func confirm() -> Bool {
        guard textField.text?.isPassword == true else {
            return false
        }
        return true
    }
    func errorMessage(_ field: String?) -> String? {
        return "\(field ?? "") \("Must be 8 characters with 1 character and 1 special character".localized)"
    }
}
