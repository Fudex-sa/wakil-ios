//
//  ReservationCoordinator.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class ReservationCoordinator: Coordinator {
    typealias PresentingView = ReservationVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension ReservationCoordinator {
    func detailsorder(id:Int) {
        guard let scene = R.storyboard.detailsreservationStoryboard.detailsreservationVC() else { return }
        scene.orderId = id
        view?.push(scene)
    }
}
