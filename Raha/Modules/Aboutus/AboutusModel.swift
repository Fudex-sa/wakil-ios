//
//  AboutusModel.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
struct AboutusModel: Codable {
    let status: Bool?
    let message: String?
    let data: AboutusDataClass?
}

// MARK: - DataClass
struct AboutusDataClass: Codable {
    let id: Int?
    let slug, image, title, description: String?
    let imageURL: String?
    let basePath: String?

    enum CodingKeys: String, CodingKey {
        case id, slug, image, title, description
        case imageURL = "image_url"
        case basePath = "base_path"
    }
}
