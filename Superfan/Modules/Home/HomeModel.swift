//
//  HomeModel.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
struct HomeModel: Codable {
    let status: Bool?
    let message: String?
    let data: HomeDataClass?
}

// MARK: - DataClass
struct HomeDataClass: Codable {
    let clubs: [SelectclubDatum]?
    let news: [NewsModelData]?
}

struct NewsModelData: Codable {
    let id: Int?
    let club: SelectclubDatum?
    let title, date: String?
    let backgrouds: String?
}
