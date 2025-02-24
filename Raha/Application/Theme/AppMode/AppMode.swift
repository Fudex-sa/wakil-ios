//
//  AppMode.swift
//  Wndo
//
//  Created by m.issa on 15/12/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

struct APP {
    static var shared: APP.Mode {
        get {
            return UD.userAppMode ?? .BUYER
        } set {
            UD.userAppMode = newValue
        }
    }
}

extension APP {
    enum Mode: String, Codable {
        case BUYER = "APP.BUYER"
        case SELLER = "APP.SELLER"
        case MARKETER = "APP.MARKETER"
    }
}
extension APP.Mode {
    static func get() -> Self {
        return APP.shared
    }
    static func set(_ mode: APP.Mode) {
        APP.shared = mode
    }
    static func reset() {
        APP.shared = .BUYER
    }
}
