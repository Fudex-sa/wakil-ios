//
//  PaymentMethodModel.swift
//  Superfan
//
//  Created by ADAM on 23/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
struct PaymentMethodModel: Codable {
    let status: Bool?
    let message: String?
    let data: [PaymentMethodDatum]?
}

// MARK: - Datum
struct PaymentMethodDatum: Codable {
    let id: Int?
    let name: String?
    let image: String?
}
struct PaymentModel: Codable {
    let status: Bool?
    let message: String?
    let data: PaymentDataClass?
}

// MARK: - DataClass
struct PaymentDataClass: Codable {
    let invoiceURL: String?
    let successLink: String?
    let errorLink: String?
    let invoiceID: Int?

    enum CodingKeys: String, CodingKey {
        case invoiceURL
        case successLink = "success_link"
        case errorLink = "error_link"
        case invoiceID = "invoiceId"
    }
}
