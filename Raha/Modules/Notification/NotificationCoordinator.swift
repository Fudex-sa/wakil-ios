//
//  NotificationCoordinator.swift
//  Raha
//
//  Created by mahmoud ezzat on 30/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class NotificationCoordinator: Coordinator, LogoutVCDelegate {
    
    
    typealias PresentingView = NotificationVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension NotificationCoordinator {
    func deletenotification() {
        guard let scene = R.storyboard.logoutStoryboard.logoutVC() else { return }
        scene.type = .notification
        scene.delegate = self
        view?.pushPop(scene)
    }
    func address() {
        view?.startLoading()
        view?.viewModel?.deletenot()
    }
    func complains() {
        guard let scene = R.storyboard.complainsStoryboard.complainsVC() else { return }
        view?.push(scene)
    }
    func detailsreservation(id:Int) {
        guard let scene = R.storyboard.detailsreservationStoryboard.detailsreservationVC() else { return }
        scene.orderId = id
        view?.push(scene)
    }
}
