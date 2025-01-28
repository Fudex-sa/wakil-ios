//
//  HomeCoordinator.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  Coordinator
class HomeCoordinator: Coordinator, ChangeClubVCDelegate {
    
    typealias PresentingView = HomeVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension HomeCoordinator {
    func detailsbackstage(id: Int) {
        guard let scene = R.storyboard.postdetailsStoryboard.postdetailsVC() else { return }
        scene.postId = id
        scene.isbackstage = true
        view?.push(scene)
    }
    func morenews() {
        guard let scene = R.storyboard.newsStoryboard.newsVC() else { return }
        view?.push(scene)
    }
    func moreposts() {
        guard let scene = R.storyboard.postsStoryboard.postsVC() else { return }
        view?.push(scene)
    }
    func notification() {
        if UD.user == nil {
            Coordinator.instance.unAuthorized()
            return
        }
        guard let scene = R.storyboard.notificationStoryboard.notificationVC() else { return }
        view?.push(scene)
    }
    func morematches() {
        guard let scene = R.storyboard.matchesMoreStoryboard.matchesMoreVC() else { return }
        view?.push(scene)
    }
    func detailsnews(id: Int) {
        guard let scene = R.storyboard.newsDetailsStoryboard.newsDetailsVC() else { return }
        scene.newsId = id
        view?.push(scene)
    }
    func detailsmatchs(id: Int) {
        if id == 0 {
            return
        }
        guard let scene = R.storyboard.matchdetailsStoryboard.matchdetailsVC() else { return }
        scene.matchId = id
        view?.push(scene)
    }
    func comments(id: Int) {
        guard let scene = R.storyboard.commentsStoryboard.commentsVC() else { return }
        scene.postId = id
        view?.push(scene)
    }
    func reply(id: Int) {
        guard let scene = R.storyboard.commentsStoryboard.commentsVC() else { return }
        scene.postId = id
        scene.type = .reply
        view?.push(scene)
    }
    func detailsbackstages(id: Int) {
        guard let scene = R.storyboard.commentsStoryboard.commentsVC() else { return }
        scene.postId = id
        scene.isbackstage = true
        view?.push(scene)
    }
    func detailsclub(id: Int) {
        guard let scene = R.storyboard.clubdetailsStoryboard.clubdetailsVC() else { return }
        scene.clubId = id
        view?.push(scene)
    }
    func detailsposts(id: Int) {
        guard let scene = R.storyboard.postdetailsStoryboard.postdetailsVC() else { return }
        scene.postId = id
        view?.push(scene)
    }
    func changeclub() {
        guard let scene = R.storyboard.changeClubStoryboard.changeClubVC() else { return }
        scene.delegate = self
        view?.pushPop(scene)
    }
    func done(club : SelectclubDatum?) {
        (view?.tabBarController as? CustomTabBarController)?.customTabBar.homeImg.tintColor = UIColor(hex: UD.club?.color ?? "")
        (view?.tabBarController as? CustomTabBarController)?.customTabBar.leagueImg.tintColor = UIColor(hex: UD.club?.color ?? "")
        (view?.tabBarController as? CustomTabBarController)?.customTabBar.mypostsImg.tintColor = UIColor(hex: UD.club?.color ?? "")
        (view?.tabBarController as? CustomTabBarController)?.customTabBar.backstageImg.tintColor = UIColor(hex: UD.club?.color ?? "")
        view?.clubLbl.text = UD.club?.name ?? ""
        view?.viewModel?.resetPaginator()
        view?.viewModel?.clearDataSource()
        view?.viewModel?.fetchhome()
        view?.changeColoe()
    }
    
}
