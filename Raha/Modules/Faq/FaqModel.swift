//
//  FaqModel.swift
//  Raha
//
//  Created by ADAM on 03/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity

struct FAQModel: Codable {
    let status: Bool?
    let message: String?
    let data: [faqdataModel]?
}

// MARK: - Datum
struct faqdataModel: Codable {
    let id: Int?
    let question, answer: String?
    let isActive: Bool?

    enum CodingKeys: String, CodingKey {
        case id, question, answer
        case isActive = "is_active"
    }
}
