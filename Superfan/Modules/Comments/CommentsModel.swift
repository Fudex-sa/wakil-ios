//
//  CommentsModel.swift
//  Superfan
//
//  Created by ADAM on 01/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
struct CommentsModel: Codable {
    let data: [CommentsDatum]?
    let status: Bool?
}

// MARK: - Datum
struct CommentsDatum: Codable {
    let id: Int?
    let reactor: Reactor?
    let comment, date: String?
    var isOwner: Bool?
    var likersCount, commentersCount, isLiked: Int?

    enum CodingKeys: String, CodingKey {
        case id, reactor, comment, date, likersCount, commentersCount, isOwner
        case isLiked = "is_liked"
    }
}

// MARK: - Reactor
struct Reactor: Codable {
    let id: Int?
    let name: String?
    let logo: String?
}
