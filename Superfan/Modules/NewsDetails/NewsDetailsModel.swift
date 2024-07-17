//
//  NewsDetailsModel.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
struct NewsDetailsModel: Codable {
    let status: Bool?
    let message: String?
    let data: NewsDetailDataClass?
}

// MARK: - DataClass
struct NewsDetailDataClass: Codable {
    let id: Int?
    let club: SelectclubDatum?
    let title, date, description: String?
    let backgrouds: [NewsDetailBackgroud]?
}

// MARK: - Backgroud
struct NewsDetailBackgroud: Codable {
    let id: Int?
    let image: String?
}
