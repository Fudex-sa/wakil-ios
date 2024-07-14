//
//  SignupModel.swift
//  Superfan
//
//  Created by ADAM on 07/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity

struct Registerstep1Model: Codable {
    let data: [RegisterModel]?
}
class RegisterModel: Codable {
    let id: Int?
    let name: String?
    init(id: Int?,name: String? ) {
        self.id = id
        self.name = name
    }
}
