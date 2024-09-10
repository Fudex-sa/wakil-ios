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
    let mix: [PostsDatum]?
    let matches: [MatchsDatum]?
}

struct NewsModelData: Codable {
    let id: Int?
    let club: SelectclubDatum?
    let title, date: String?
    let backgrouds: String?
}


struct MatchsModel: Codable {
    let data: [MatchsDatum]?
    let status: Bool?
    let message: String?
}

// MARK: - Datum
struct MatchsDatum: Codable {
    let id, homeTeamID, awayTeamID: Int?
    let date, liveStatus: String?
    let status: Int?
    let leagueName: String?
    let team1, team2: MatchsTeam?

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
struct MatchsTeam: Codable {
    let id: Int?
    let title: String?
    let logo: String?
    let score: Int?
}
struct MatchesModel: Codable {
    let status: Bool?
    let message: String?
    let data: MatchesDataClass?
}

// MARK: - DataClass
struct MatchesDataClass: Codable {
    let standing: [Standing]?
    let nextMatches: [MatchsDatum]?
}
struct PostsModel: Codable {
    let data: [PostsDatum]?
    let status: Bool?
    let message: String?
}

// MARK: - Datum
struct PostsDatum: Codable {
    let id: Int?
    let user: User?
    let type: String?
    let title, description, date: String?
    let files: [File]?
    var is_liked: Int?
    let backgroundImg: String?
    var likersCount: Int?
    var commentersCount: Int?
}

// MARK: - File
struct File: Codable {
    let id: Int?
    let value: String?
    let type: String?
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let name: String?
    let logo: String?
    let type: String?
}
