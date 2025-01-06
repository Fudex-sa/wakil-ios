//
//  TournamentsModel.swift
//  Superfan
//
//  Created by ADAM on 24/12/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
struct TournamentsModel: Codable {
    let status: Bool?
    let message: String?
    let data: [TournamentsDatum]?
}

// MARK: - Datum
struct TournamentsDatum: Codable {
    let id: Int?
    let name: String?
    let type: Int?
    let image: String?
}

struct StandingsModel: Codable {
    let status: Bool?
    let message: String?
    let data: [Standing]?
}
struct Standings1Model: Codable {
    let status: Bool?
    let message: String?
    let data: [StandingsMultiModel]?
}
struct StandingsMultiModel: Codable {
    let title: String?
    let data: [Standing]?
}
