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
    let data: PostdetailsDataClass?
}

// MARK: - DataClass
struct PostdetailsDataClass: Codable {
    let id: Int?
    let user: User?
    let title, description, date: String?
    let files: [File]?
    let backgroundImg: String?
    let likersCount, commentersCount, isLiked: Int?

    enum CodingKeys: String, CodingKey {
        case id, user, title, description, date, files, backgroundImg, likersCount, commentersCount
        case isLiked = "is_liked"
    }
}

// MARK: - File


struct DeletePost: Codable {
    var message: String?
}
