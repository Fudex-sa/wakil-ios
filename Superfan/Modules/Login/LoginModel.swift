//
//  LoginModel.swift
//  Superfan
//
//  Created by ADAM on 07/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity

struct DatumSelectCountryModel: Codable {
    let id: Int?
    let code, image, name: String?
    let mobile_length: Int?
}
