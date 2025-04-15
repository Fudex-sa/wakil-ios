//
//  DetailsreservationCoordinator.swift
//  Raha
//
//  Created by mahmoud ezzat on 05/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class DetailsreservationCoordinator: Coordinator, RatingPopupVCDelegate {
    typealias PresentingView = DetailsreservationVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension DetailsreservationCoordinator {
    func cancelorder(id:Int) {
        guard let scene = R.storyboard.cancelOrderStoryboard.cancelOrderVC() else { return }
        scene.centerId = id
        view?.push(scene)
    }
    func rateorder(id:Int) {
        guard let scene = R.storyboard.ratingPopupStoryboard.ratingPopupVC() else { return }
        scene.orderId = id
        scene.delegate = self
        view?.pushPop(scene)
    }
    func done() {
        view?.startLoading()
        view?.viewModel?.fetchorderdetails()
    }
}
