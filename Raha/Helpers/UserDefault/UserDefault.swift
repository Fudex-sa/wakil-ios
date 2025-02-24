//
//  UserDefault.swift
//  BaseIOS
//
//  Created by Mabdu on 03/06/2021.
//  Copyright © 2021 com.mabdu. All rights reserved.
//

import Foundation

// MARK: - ...  UD for single object from Defaults proprties
internal var UD: Defaults {
    if Defaults.Static.instance == nil {
        Defaults.Static.instance = Defaults()
    }
    return Defaults.Static.instance!
}

