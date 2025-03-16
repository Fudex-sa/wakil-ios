//
//  AddressModel.swift
//  Raha
//
//  Created by ADAM on 11/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
struct AddressesModel: Codable {
    let data: [AddressesDatum]?
    let status: Bool?
    let message: String?
}

// MARK: - Datum
struct AddressesDatum: Codable {
    let id: Int?
    let street: String?
    let lat, lng: String?
    let isDefault: Int?
    let stateID: CityID?
    let cityID: CityID?
    let district: String?

    enum CodingKeys: String, CodingKey {
        case id, street, lat, lng
        case isDefault = "is_default"
        case stateID = "state_id"
        case cityID = "city_id"
        case district
    }
}

// MARK: - CityID
struct CityID: Codable {
    let id: Int?
    let name: String?
    let stateID: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case stateID = "state_id"
    }
}

struct DeleteaddresssModel: Codable {
    let message: String?
}
