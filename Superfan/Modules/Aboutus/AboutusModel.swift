//
//  AboutusModel.swift
//  Superfan
//
//  Created by ADAM on 10/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
struct SettingModel: Codable {
    let status: Bool?
    let message: String?
    let data: SettingData?
}

struct SettingData: Codable  {
    let privacy_policy: String?
    let refund_policy: String?
    let about_us: String?
    let terms_condition: String?
    let app_status: String?
    let android_last_stable_version: String?
    let ios_last_stable_version: String?
    let faceBook_link: String?
    let twitter_link: String?
    let instagram_link: String?
    let linkedIn_link: String?
    let id: Int?
    let key, value: String?
}
