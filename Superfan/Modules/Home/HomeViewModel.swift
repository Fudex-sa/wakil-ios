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
    var posts: Publisher<[PostsDatum]> = .init()
    var clubs: Publisher<[SelectclubDatum]> = .init()
    var matches: Publisher<[MatchsDatum]> = .init()
    var sliders: Publisher<[SliderModelData]> = .init()
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
        NetworkManager.instance.paramaters["league_id"] = 232
        NetworkManager.instance.paramaters["limit"] = 4
        NetworkManager.instance.paramaters["country_id"] = countryId.value ?? 0
        NetworkManager.instance.request(NetworkConfigration.EndPoint.home.rawValue, type: .get, HomeModel.self)?.response(error: { [weak self] error in
            self?.error.send(error)
        }, receiveValue: { [weak self] model in
            guard let model = model else { return }
            self?.posts.send( model.data?.posts ?? [])
            self?.clubs.send(model.data?.clubs ?? [])
            self?.append(contentsOf: model.data?.news ?? [])
            self?.matches.send(model.data?.matches ?? [])
            self?.sliders.send(model.data?.sliders ?? [])
            self?.publisher()
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
