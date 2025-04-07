//
//  DetailscentersModel.swift
//  Raha
//
//  Created by ADAM on 27/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
struct DetailscentersModel: Codable {
    let status: Bool?
    let message: String?
    let data: DetailscentersDataClass?
}

// MARK: - DataClass
struct DetailscentersDataClass: Codable {
    let id: Int?
    let name, description, address: String?
    let image: String?
    let rate: Double?
    let homeServicesAvailable: Int?
    let distance: String?
    let images: [Image]?
    let serviceTypes: [ServicetypeDatum]?
    let services: [Service]?

    enum CodingKeys: String, CodingKey {
        case id, name, description, address, image, rate
        case homeServicesAvailable = "home_services_available"
        case distance, images
        case serviceTypes = "service_types"
        case services
    }
}

// MARK: - Image
struct Image: Codable {
    let id: Int?
    let image: String?
}

// MARK: - Service
struct Service: Codable {
    let id: Int?
    let name: String?
    let image: String?
    let serviceType, providerType, price, duration: String?
    let maxConcurrentRequests: Int?
    let locationType: String?

    enum CodingKeys: String, CodingKey {
        case id, name, image
        case serviceType = "service_type"
        case providerType = "provider_type"
        case price, duration
        case maxConcurrentRequests = "max_concurrent_requests"
        case locationType = "location_type"
    }
}
