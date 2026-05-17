//
//  ValidatorFacade.swift
//  BaseIOS
//
//  Created by Mabdu on 06/06/2021.
//  Copyright © 2021 com.mabdu. All rights reserved.
//

import Foundation
import UIKit
// MARK: - ...  Validator facade
@objc protocol ValidatorTextFieldDelegate: NSObjectProtocol {
    @objc optional func textFieldDidEndEditing(_ textField: UITextField)
    @objc optional func textFieldDidBeginEditing(_ textField: UITextField)
    @objc optional func textFieldDidChange(_ textField: UITextField)
}

