//
//  HomeViewModel.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  ViewModel
class HomeViewModel: BaseViewModel , DataSourceViewModel{
    var countryId: Publisher<Int> = .init()
    var clubId: Publisher<Int> = .init()
    var postId: Publisher<Int> = .init()
    var items: Publisher<[NewsModelData]> = .init()
    var events: Publisher<[PostsDatum]> = .init()
    var posts: Publisher<[PostsDatum]> = .init()
    var clubs: Publisher<[SelectclubDatum]> = .init()
    var matches: Publisher<[MatchsDatum]> = .init()
    var matchFinish: Publisher<Bool> = .init()
    var matchestab: Publisher<MatchesModel> = .init()
    var matchFinishtab: Publisher<Bool> = .init()
    var newsfinish: Publisher<Bool> = .init()
    var postsfinish: Publisher<Bool> = .init()
    var eventsfinish: Publisher<Bool> = .init()
    var likedata: Publisher<UserRoot> = .init()
    var settingdata: Publisher<SettingModel> = .init()
}
// MARK: - ...  ViewModel Contract
extension HomeViewModel {
}
// MARK: - ...  Example of network response
extension HomeViewModel {
    func fetchhome() {
        if UD.club?.id ?? 0 != 0 {
            NetworkManager.instance.paramaters["club_id"] = UD.club?.id ?? 0
        }
        NetworkManager.instance.paramaters["limit"] = 4
        NetworkManager.instance.paramaters["country_id"] = countryId.value ?? 0
        NetworkManager.instance.request(NetworkConfigration.EndPoint.home.rawValue, type: .get, HomeModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.events.send( model.data?.mix ?? [])
            self?.clubs.send(model.data?.clubs ?? [])
            self?.paginator(respnod: model.data?.mix)
            self?.matches.send(model.data?.matches ?? [])
            self?.eventsfinish.send(true)
        }).store(self)
    }
    
    func fetchtodaymatch() {
        if UD.club?.id ?? 0 != 0 {
            NetworkManager.instance.paramaters["club_id"] = UD.club?.id ?? 0
        }
        NetworkManager.instance.paramaters["limit"] = 4
        NetworkManager.instance.request(NetworkConfigration.EndPoint.todaymatxh.rawValue, type: .get, MatchsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.matches.send(model.data ?? [])
            self?.matchFinish.send(true)
        }).store(self)
    }
    
    func fetchmatchtab() {
        if UD.club?.id ?? 0 != 0 {
            NetworkManager.instance.paramaters["club_id"] = UD.club?.id ?? 0
        }
        NetworkManager.instance.request(NetworkConfigration.EndPoint.matches.rawValue, type: .get, MatchesModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.matchestab.send(model)
            self?.matchFinishtab.send(true)
        }).store(self)
    }
    func fetchnews() {
        if UD.club?.id ?? 0 != 0 {
            NetworkManager.instance.paramaters["club_id"] = UD.club?.id ?? 0
        }
        NetworkManager.instance.request(NetworkConfigration.EndPoint.news.rawValue, type: .get, NewsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.append(contentsOf: model.data ?? [])
            self?.paginator(respnod: model.data)
            self?.newsfinish.send(true)
        }).store(self)
    }
    func fetchposts() {
        if UD.club?.id ?? 0 != 0 {
            NetworkManager.instance.paramaters["club_id"] = UD.club?.id ?? 0
        }
        NetworkManager.instance.request(NetworkConfigration.EndPoint.posts.rawValue, type: .get, PostsModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            var items:[PostsDatum] = []
            items.append(contentsOf: self?.posts.value ?? [])
            items.append(contentsOf: model.data ?? [])
            self?.posts.send(items)
            self?.paginator(respnod: model.data)
            self?.postsfinish.send(true)
        }).store(self)
    }
    func likepost() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.posts.rawValue)/\(postId.value ?? 0)/like", type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.likedata.send(model)
        }).store(self)
    }
    func unlikepost() {
        NetworkManager.instance.request("\(NetworkConfigration.EndPoint.posts.rawValue)/\(postId.value ?? 0)/disLike", type: .post, UserRoot.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.likedata.send(model)
        }).store(self)
       
    }
    func fetchsetting() {
        NetworkManager.instance.request(NetworkConfigration.EndPoint.settingsubscribe.rawValue, type: .get, SettingModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.settingdata.send(model)
        }).store(self)
    }
}
