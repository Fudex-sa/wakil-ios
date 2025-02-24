//
//  Guard.swift
//  BaseIOS
//
//  Created by Mabdu on 06/06/2021.
//  Copyright © 2021 com.mabdu. All rights reserved.
//

import Foundation
import UIKit


// MARK: - ...  Guard
protocol Guard {
    var textField: UITextField! { get set }
    func confirm() -> Bool
    func errorMessage(_ field: String?) -> String?
}
