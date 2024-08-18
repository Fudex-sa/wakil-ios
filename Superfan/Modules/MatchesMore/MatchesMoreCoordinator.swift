//
//  MatchesMoreCoordinator.swift
//  Superfan
//
//  Created by ADAM on 18/08/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class MatchesMoreCoordinator: Coordinator {
    typealias PresentingView = MatchesMoreVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension MatchesMoreCoordinator {
    func detailsmatchs(id: Int) {
        guard let scene = R.storyboard.matchdetailsStoryboard.matchdetailsVC() else { return }
        scene.matchId = id
        view?.push(scene)
    }
}
