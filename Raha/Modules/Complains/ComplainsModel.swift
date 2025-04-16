//
//  ComplainsModel.swift
//  Raha
//
//  Created by mahmoud ezzat on 16/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
struct ComplainsModel: Codable {
    let status: Bool?
    let message: String?
    let data: [ComplainsDatum]?
}

// MARK: - Datum
struct ComplainsDatum: Codable {
    let id: Int?
    let type, message: String?
    let reply: String?
    let status: Int?
}
