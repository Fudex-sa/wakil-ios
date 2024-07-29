//
//  NotificationCoordinator.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class NotificationCoordinator: Coordinator {
    typealias PresentingView = NotificationVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension NotificationCoordinator {
    func notdetails(id: Int?) {
        guard let scene = R.storyboard.newsDetailsStoryboard.newsDetailsVC() else { return }
        scene.newsId = id ?? 0
        view?.push(scene)
    }
}
