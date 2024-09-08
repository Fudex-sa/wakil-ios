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
    func morenews() {
        guard let scene = R.storyboard.newsStoryboard.newsVC() else { return }
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
        guard let scene = R.storyboard.matchdetailsStoryboard.matchdetailsVC() else { return }
        scene.matchId = id
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
    func done() {
        view?.clubLbl.text = UD.club?.name ?? ""
        if view?.type == 0 {
            view?.showevents()
        }else if view?.type == 1 {
            view?.showmatches()
        }else if view?.type == 2 {
            view?.shownews()
        }else if view?.type == 3 {
            view?.showposts()
        }
        view?.changeColoe()
    }
    
}
