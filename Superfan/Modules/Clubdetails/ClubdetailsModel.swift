//
//  ClubdetailsModel.swift
//  Superfan
//
//  Created by ADAM on 18/08/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
struct ClubdetailsModel: Codable {
    let status: Bool?
    let message: String?
    let data: ClubdetailsMDataClass?
}

// MARK: - DataClass
struct ClubdetailsMDataClass: Codable {
    let id: Int?
    let name: String?
    let photo: String?
    let foundationDate: String?
    let generalInfo: String?
    let standing: [Standing]?
    let players: [Player]?
    let prizes: [Prize]?

    enum CodingKeys: String, CodingKey {
        case id, name, photo
        case foundationDate = "foundation_date"
        case generalInfo = "general_info"
        case standing, players, prizes
    }
}

// MARK: - Player
struct Player: Codable {
    let id: Int?
    let playerName: String?
    let playerImage: String?
    let positionName, nationalityFlag: String?

    enum CodingKeys: String, CodingKey {
        case id
        case playerName = "player_name"
        case playerImage = "player_image"
        case positionName = "position_name"
        case nationalityFlag = "nationality_flag"
    }
}

// MARK: - Prize
struct Prize: Codable {
    let id: Int?
    let name: String?
}

// MARK: - Standing
struct Standing: Codable {
    let id: Int?
    let teamName: String?
    let teamLogo: String?
    let played, goalsIn, goalsOut, win: Int?
    let lose, draw, order: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case played
        case goalsIn = "goals_in"
        case goalsOut = "goals_out"
        case win, lose, draw, order
    }
}
