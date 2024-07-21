//
//  SelectclubModel.swift
//  Superfan
//
//  Created by ADAM on 08/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
struct SelectclubModel: Codable {
    let data: [SelectclubDatum]?
    let status: Bool?
    let message: String?
}

// MARK: - Datum
struct SelectclubDatum: Codable {
    let id: Int?
    var name, color: String?
    let photo: String?
}
