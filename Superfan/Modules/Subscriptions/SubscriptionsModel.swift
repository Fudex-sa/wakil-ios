//
//  SubscriptionsModel.swift
//  Superfan
//
//  Created by ADAM on 19/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
class SubscriptionsModel: Codable {
}
struct PackageModel: Codable {
    let data: [PackageDatum]?
    let status: Bool?
    let message: String?
}

// MARK: - Datum
struct PackageDatum: Codable {
    let id: Int?
    let title: String?
    let price, monthesCount: Int?
    let features: [String]?
    let club: User?
}
