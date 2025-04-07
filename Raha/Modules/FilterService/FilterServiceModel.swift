//
//  FilterServiceModel.swift
//  Raha
//
//  Created by ADAM on 02/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
class FilterServiceModel: Codable {
    var distance: String?
    var servicetype: String?
    var loctype: String?
    var gender: String?
    var rate: String?
}
struct ServicetypeModel: Codable {
    let status: Bool?
    let message: String?
    let data: [ServicetypeDatum]?
}

// MARK: - Datum
class ServicetypeDatum: Codable {
    let key, value: String?
    init(key: String?, value: String?) {
        self.key = key
        self.value = value
    }
}
