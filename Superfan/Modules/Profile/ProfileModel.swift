//
//  ProfileModel.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
struct ProfileModel: Codable {
    let message: String?
    var data: UserRoot.User?
}
