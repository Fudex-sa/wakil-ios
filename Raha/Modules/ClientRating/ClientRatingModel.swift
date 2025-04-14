//
//  ClientRatingModel.swift
//  Raha
//
//  Created by mahmoud ezzat on 06/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
struct ClientRatingModel: Codable {
    let data: [RatingDatum]?
}

// MARK: - Datum
struct RatingDatum: Codable {
    let rating: Int?
    let comment, createdAt: String?
    let user: UserRating?

    enum CodingKeys: String, CodingKey {
        case rating, comment
        case createdAt = "created_at"
        case user
    }
}

// MARK: - User
struct UserRating: Codable {
    let id: Int?
    let name: String?
    let avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case avatarURL = "avatar_url"
    }
}
