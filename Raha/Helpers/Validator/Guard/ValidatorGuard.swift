//
//  ValidatorGuard.swift
//  BaseIOS
//
//  Created by Mabdu on 06/06/2021.
//  Copyright © 2021 com.mabdu. All rights reserved.
//

import Foundation
import UIKit


// MARK: - ...  Validate for every guard
protocol ValidatorGuard: NSObjectProtocol {
    func validateGuard(_ textField: UITextField) -> Bool?
    func validateGuard(_ textField: GuardModel) -> Bool
    func guardModel(_ textField: UITextField) -> GuardModel?

}
