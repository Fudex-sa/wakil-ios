//
//  TournamentsViewModel.swift
//  Superfan
//
//  Created by ADAM on 24/12/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class TournamentsViewModel: BaseViewModel , DataSourceViewModel{
    var leagueId: Publisher<Int> = .init()
    var leagues: Publisher<[TournamentsDatum]> = .init()
    var items: Publisher<[MatchsDatum]> = .init()
    var standings: Publisher<[StandingsMultiModel]> = .init()
    var upcomming: Publisher<[MatchsDatum]> = .init()
    var publishleague: Publisher<Bool> = .init()
    var publishupcomming: Publisher<Bool> = .init()
    var publishstanding: Publisher<Bool> = .init()
}
// MARK: - ...  ViewModel Contract
extension TournamentsViewModel {
}
// MARK: - ...  Example of network response
extension TournamentsViewModel {
    func fetchleagues() {
        NetworkManager.instance.request(NetworkConfigration.EndPoint.leagues.rawValue, type: .get, TournamentsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.leagues.send(model.data ?? [])
            self?.publishleague.send(true)
        }).store(self)
    }
    func fetchtodaymatch() {
        if leagueId.value ?? 0 != 0 {
            NetworkManager.instance.paramaters["league_id"] = leagueId.value ?? 0
        }
        NetworkManager.instance.request(NetworkConfigration.EndPoint.nextmatches.rawValue, type: .get, MatchsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.upcomming.send(model.data ?? [])
            self?.publishupcomming.send(true)
        }).store(self)
    }
    func fetchperviousymatch() {
        if leagueId.value ?? 0 != 0 {
            NetworkManager.instance.paramaters["league_id"] = leagueId.value ?? 0
        }
        NetworkManager.instance.request(NetworkConfigration.EndPoint.perviousmatch.rawValue, type: .get, MatchsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.append(contentsOf: model.data ?? [])
            self?.paginator(respnod: model.data)
            self?.publisher()
        }).store(self)
    }
    func fetchstandings() {
        if leagueId.value ?? 0 != 0 {
            NetworkManager.instance.paramaters["league_id"] = leagueId.value ?? 0
        }
        NetworkManager.instance.request(NetworkConfigration.EndPoint.standing.rawValue, type: .get, StandingsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            var standing = StandingsMultiModel(title: "League Table".localized, data: model.data ?? [])
            var standingList : [StandingsMultiModel] = []
            standingList.append(standing)
            self?.standings.send(standingList)
            self?.publishstanding.send(true)
        }).store(self)
    }
    func fetchstandingsmulti() {
        if leagueId.value ?? 0 != 0 {
            NetworkManager.instance.paramaters["league_id"] = leagueId.value ?? 0
        }
        NetworkManager.instance.request(NetworkConfigration.EndPoint.standing.rawValue, type: .get, Standings1Model.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            var standingList : [StandingsMultiModel] = []
            var index = 0
            for item in model.data ?? [] {
                var standing = StandingsMultiModel(title: "\("Group".localized) \(index + 1)", data: item.data ?? [])
                standingList.append(standing)
                index = index + 1
            }
          
            self?.standings.send(standingList)
            self?.publishstanding.send(true)
        }).store(self)
    }
}
