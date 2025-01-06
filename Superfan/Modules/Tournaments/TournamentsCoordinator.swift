//
//  TournamentsCoordinator.swift
//  Superfan
//
//  Created by ADAM on 24/12/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class TournamentsCoordinator: Coordinator {
    typealias PresentingView = TournamentsVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension TournamentsCoordinator {
    func detailsclub(id: Int) {
        guard let scene = R.storyboard.clubdetailsStoryboard.clubdetailsVC() else { return }
        scene.clubId = id
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
}
