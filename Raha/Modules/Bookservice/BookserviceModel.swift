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
    let sub_total: Double?
    let delivery_fee: Double?
    let vat_amount: Double?
    let total_price: Double?
    let vat_rate: String?
    let data: [SlotsDatum]?
}

// MARK: - Datum
struct SlotsDatum: Codable {
    var slots: [Slot]?
    let serviceID: Int?
    let serviceName, providerType, price, duration: String?
    var isselect: Bool? = false

    enum CodingKeys: String, CodingKey {
        case slots, isselect, duration
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
struct PaymethodModel: Codable {
    let status: Bool?
    let message: String?
    let data: PaymethodDataClass?
}

// MARK: - DataClass
struct PaymethodDataClass: Codable {
    let paymentMethods: [PaymentMethod]?
    let orderID: Int?

    enum CodingKeys: String, CodingKey {
        case paymentMethods = "payment_methods"
        case orderID = "order_id"
    }
}

// MARK: - PaymentMethod
struct PaymentMethod: Codable {
    let paymentMethodID: Int?
    let paymentMethodAr, paymentMethodEn, paymentMethodCode: String?
    let isDirectPayment: Bool?
    let serviceCharge, totalAmount: Double?
    let currencyISO: String?
    let imageURL: String?
    let isEmbeddedSupported: Bool?
    let paymentCurrencyISO: String?

    enum CodingKeys: String, CodingKey {
        case paymentMethodID = "PaymentMethodId"
        case paymentMethodAr = "PaymentMethodAr"
        case paymentMethodEn = "PaymentMethodEn"
        case paymentMethodCode = "PaymentMethodCode"
        case isDirectPayment = "IsDirectPayment"
        case serviceCharge = "ServiceCharge"
        case totalAmount = "TotalAmount"
        case currencyISO = "CurrencyIso"
        case imageURL = "ImageUrl"
        case isEmbeddedSupported = "IsEmbeddedSupported"
        case paymentCurrencyISO = "PaymentCurrencyIso"
    }
}
