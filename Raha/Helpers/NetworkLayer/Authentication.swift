//
//  Authintiaction.swift
//  Wndo
//
//  Created by Mabdu on 01/11/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

struct Authentication {
    static let shared = Authentication()
    var GUEST: String? {
        get {
            UD.GUEST
        }
    }

    func getAuth() -> String {
        if let token = UserRoot.token() {
            return "Bearer " + token
        }
        else {
            return "Bearer " + (GUEST ?? "")
        }
    }
}
