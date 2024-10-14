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
    let added_tax: String?
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
struct MysubscribeModel: Codable {
    let data: [MysubscribeDatum]?
    let status: Bool?
    let message: String?
}

// MARK: - Datum
struct MysubscribeDatum: Codable {
    let id: Int?
    let title: String?
    var price: Int?
    let club: User?
    let monthesCount: Int?
    let expireDate: String?
    let features: [String]?

    enum CodingKeys: String, CodingKey {
        case id, club, title, monthesCount,price
        case expireDate = "expire_date"
        case features
    }
}
struct ChecksubscribeModel: Codable {
    let status: Bool?
}
