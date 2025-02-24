//
//  GuardRequired.swift
//  BaseIOS
//
//  Created by Mabdu on 06/06/2021.
//  Copyright © 2021 com.mabdu. All rights reserved.
//

import Foundation
import UIKit


// MARK: - ...  Guard Length
internal struct GuardLength: Guard {
    
    // MARK: - ...  vars
    private var minimumLength: Int = 1
    private var maximumLength: Int?
    var textField: UITextField!
    var max: Int? {
        get {
            return maximumLength
        }
    }
    // MARK: - ...  init
    init(minimumLength: Int = 1, maximumLength: Int? = nil) {
        self.minimumLength = minimumLength
        self.maximumLength = maximumLength
    }
    
    // MARK: - ...  functions
    func confirm() -> Bool {
        var valid = (textField.text?.count ?? 0 >= minimumLength)
        if valid {
            if let maximumLength = self.maximumLength {
                valid = (textField.text?.count ?? 0 <= maximumLength)
            }
        }
        return valid
    }
    func errorMessage(_ field: String?) -> String? {
        var valid = (textField.text?.count ?? 0 >= minimumLength)
        if valid {
            if let maximumLength = self.maximumLength {
                valid = (textField.text?.count ?? 0 <= maximumLength)
                if !valid {
                    return "\(field ?? "") \("the length must be at maximum".localized) \(maximumLength)"
                }
            }
        } else {
            return "\(field ?? "") \("the length must be at minimum".localized) \(minimumLength)"
        }
        return nil
    }
}
