//
//  HomeModel.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
struct HomeModel: Codable {
    let data: [HomeDatum]?
    let status: Bool?
    let message: String?
    let meta: Meta?
}

// MARK: - Datum
struct HomeDatum: Codable {
    let id: Int?
    let name, description: String?
    let address: String?
    let image: String?
    let rate: Double?
    let distance: String?
    let serviceTypes: [String]?

    enum CodingKeys: String, CodingKey {
        case id, name, description, address, image, rate, distance
        case serviceTypes = "service_types"
    }
}
struct Meta: Codable {
    let currentPage: Int?
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
    }
}
struct SlidersModel: Codable {
    let data: [SlidersDatum]?
    let status: Bool?
    let message: String?
}

// MARK: - Datum
struct SlidersDatum: Codable {
    let id: Int?
    let title, desc: String?
    let sortOrder: Int?
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id, title, desc
        case sortOrder = "sort_order"
        case image
    }
}

struct NotcountModel: Codable {
    let data: Int?
}
