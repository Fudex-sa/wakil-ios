//
//  PostdetailsModel.swift
//  Superfan
//
//  Created by ADAM on 01/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
struct PostdetailsModel: Codable {
    let status: Bool?
    let message: String?
    let data: PostsDatum?
}
