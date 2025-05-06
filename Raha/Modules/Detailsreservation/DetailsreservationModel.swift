//
//  DetailsreservationModel.swift
//  Raha
//
//  Created by mahmoud ezzat on 05/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
struct DetailsreservationModel: Codable {
    let status: Bool?
    let message: String?
    let data: DetailsreservationDataClass?
}

// MARK: - DataClass
struct DetailsreservationDataClass: Codable {
    let id, statusKey: Int?
    let status: String?
    let service: [Service]?
    let serviceTypes: [String]?
    let price: String?
    let is_refunded: Int?
    let isGift: Int?
    let locationType, date, time: String?
    let rating: Rating?
    let branch: Branch?
    let gift: Gift?

    enum CodingKeys: String, CodingKey {
        case id, is_refunded
        case statusKey = "status_key"
        case status, service
        case serviceTypes = "service_types"
        case price
        case isGift = "is_gift"
        case locationType = "location_type"
        case date, time, rating, branch, gift
    }
}

// MARK: - Branch
struct Branch: Codable {
    let name: String?
    let image: String?
    let rate: Int?
    let distance: String?
}

// MARK: - Gift
struct Gift: Codable {
    let name, mobile, gender, address: String?
}

// MARK: - Rating
struct Rating: Codable {
    let rating: Int?
    let comment, createdAt: String?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case rating, comment
        case createdAt = "created_at"
        case user
    }
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let name: String?
    let avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case avatarURL = "avatar_url"
    }
}

// MARK: - Service
