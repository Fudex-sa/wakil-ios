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
    var id: Int?
    var lat, lng: String?
    var isDefault: Int?
    var stateID: CityID?
    var cityID: CityID?
    var district: String?

    enum CodingKeys: String, CodingKey {
        case id, lat, lng
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
