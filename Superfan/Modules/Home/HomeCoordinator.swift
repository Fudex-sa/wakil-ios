//
//  HomeCoordinator.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

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
    func detailsnews(id: Int) {
        guard let scene = R.storyboard.newsDetailsStoryboard.newsDetailsVC() else { return }
        scene.newsId = id
        view?.push(scene)
    }
    func changeclub() {
        guard let scene = R.storyboard.changeClubStoryboard.changeClubVC() else { return }
        scene.delegate = self
        view?.pushPop(scene)
    }
    func done() {
        view?.clubLbl.text = UD.club?.name ?? ""
        view?.viewModel?.resetPaginator()
        view?.viewModel?.clearDataSource()
        view?.viewModel?.fetchhome()
    }
    
}
