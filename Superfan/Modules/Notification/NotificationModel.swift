//
//  NotificationModel.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
struct NotificationsModel: Codable {
    let data: [NotificationsDatum]?
    let status: Bool?
    let message: String?
}

// MARK: - Datum
struct NotificationsDatum: Codable {
    let id,itemId: Int?
    let title: String?
    let isRead: Int?
    let notificationType, date: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case itemId = "item_id"
        case isRead = "is_read"
        case notificationType = "notification_type"
        case date
    }
}
