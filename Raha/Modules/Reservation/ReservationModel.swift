//
//  ReservationModel.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
struct ReservationModel: Codable {
    let status: Bool?
    let message: String?
    let data: [ReservationDatum]?
}

// MARK: - Datum
struct ReservationDatum: Codable {
    let id, is_gift, status_key: Int?
    let status: String?
    let service: [Service]?
    var serviceTypes: [String]?
    let price, date, time: String?

    enum CodingKeys: String, CodingKey {
        case id, status, service, is_gift,status_key
        case serviceTypes = "service_types"
        case price, date, time
    }
}

// MARK: - Service
