//
//  ValidatorUIType.swift
//  BaseIOS
//
//  Created by Mabdu on 07/06/2021.
//  Copyright © 2021 com.mabdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  Guard UI Type of each text field
enum ValidatorUIType {
    case underline
    case infoMark
    case label
    case message
    case scroll(scroll: UIScrollView)
    // MARK: - ... only red in text
    case none
}
