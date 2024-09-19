//
//  SubscriptionsCoordinator.swift
//  Superfan
//
//  Created by ADAM on 19/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class SubscriptionsCoordinator: Coordinator, ChangeClubVCDelegate {
    typealias PresentingView = SubscriptionsVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension SubscriptionsCoordinator {
    func changeclub() {
        guard let scene = R.storyboard.changeClubStoryboard.changeClubVC() else { return }
        scene.delegate = self
        scene.issubscribe = true
        view?.pushPop(scene)
    }
    func done(club : SelectclubDatum?) {
        view?.clubId = club?.id ?? 0
        view?.club = club
        view?.clickBtn()
    }
}
