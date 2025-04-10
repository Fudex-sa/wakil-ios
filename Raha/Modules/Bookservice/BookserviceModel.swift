//
//  BookserviceModel.swift
//  Raha
//
//  Created by mahmoud ezzat on 07/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
struct BookserviceModel: Codable {
    let status: Bool?
    let message: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let paymentURL: String?
    let orderID: Int?
    let successURL, failURL: String?

    enum CodingKeys: String, CodingKey {
        case paymentURL = "payment_url"
        case orderID = "order_id"
        case successURL = "success_url"
        case failURL = "fail_url"
    }
}


struct SlotsModel: Codable {
    let status: Bool?
    let message: String?
    let data: [SlotsDatum]?
}

// MARK: - Datum
struct SlotsDatum: Codable {
    var slots: [Slot]?
    let serviceID: Int?
    let serviceName, providerType, price: String?
    var isselect: Bool? = false

    enum CodingKeys: String, CodingKey {
        case slots, isselect
        case serviceID = "service_id"
        case serviceName = "service_name"
        case providerType = "provider_type"
        case price
    }
}

// MARK: - Slot
struct Slot: Codable {
    let from, to: String?
    let active: Bool?
    var isselect: Bool? = false
}
