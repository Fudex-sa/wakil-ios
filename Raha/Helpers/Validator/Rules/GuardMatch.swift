//
//  GuardRequired.swift
//  BaseIOS
//
//  Created by Mabdu on 06/06/2021.
//  Copyright © 2021 com.mabdu. All rights reserved.
//

import Foundation
import UIKit


// MARK: - ...  Guard Match
internal struct GuardMatch: Guard {
    
    // MARK: - ...  vars
    private var matchWith: UITextField?
    var textField: UITextField!
    
    // MARK: - ...  init
    init(matchWith: UITextField?) {
        self.matchWith = matchWith
    }
    
    // MARK: - ...  functions
    func confirm() -> Bool {
        guard textField.text == matchWith?.text else {
            return false
        }
        return true
    }
    func errorMessage(_ field: String?) -> String? {
        return "\(field ?? "") \("doesn't match".localized)"
    }
}
