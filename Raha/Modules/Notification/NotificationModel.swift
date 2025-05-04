//
//  NotificationModel.swift
//  Raha
//
//  Created by mahmoud ezzat on 30/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity

struct NotificationModel: Codable {
    let data: [NotificationDatum]?
    let pagination: Pagination?
}

// MARK: - Datum
struct NotificationDatum: Codable {
    let date: String?
    let notifications: [Notificationdata]?
}

// MARK: - Notification
struct Notificationdata: Codable {
    let id: Int?
    let title, body, type: String?
    let itemID: Int?
    let sentAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, body, type
        case itemID = "item_id"
        case sentAt = "sent_at"
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    let currentPage, lastPage, perPage, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case lastPage = "last_page"
        case perPage = "per_page"
        case total
    }
}
