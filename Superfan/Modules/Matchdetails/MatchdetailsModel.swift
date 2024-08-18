//
//  MatchdetailsModel.swift
//  Superfan
//
//  Created by ADAM on 18/08/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
struct MatchdetailsModel: Codable {
    let status: Bool?
    let message: String?
    let data: MatchdetailsDataClass?
}

// MARK: - DataClass
struct MatchdetailsDataClass: Codable {
    let id, homeTeamID, awayTeamID: Int?
    let date, liveStatus: String?
    let status: Int?
    let leagueName: String?
    let team1, team2: Team?

    enum CodingKeys: String, CodingKey {
        case id
        case homeTeamID = "home_team_id"
        case awayTeamID = "away_team_id"
        case date, liveStatus, status
        case leagueName = "league_name"
        case team1, team2
    }
}

// MARK: - Team
struct Team: Codable {
    let id: Int?
    let title: String?
    let logo: String?
    let score, penaltyScore, shots, targetShots: Int?
    let possession, pass, passAccuracy, missedPass: Int?
    let fouls, offsides, corners, redCards: Int?
    let yellowCards: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, logo, score
        case penaltyScore = "penalty_score"
        case shots
        case targetShots = "target_shots"
        case possession, pass
        case passAccuracy = "pass_accuracy"
        case missedPass = "missed_pass"
        case fouls, offsides, corners
        case redCards = "red_cards"
        case yellowCards = "yellow_cards"
    }
}

struct statistecModel: Codable {
    let title, result1, result2: String
}
