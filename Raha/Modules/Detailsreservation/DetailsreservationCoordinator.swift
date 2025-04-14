//
//  DetailsreservationCoordinator.swift
//  Raha
//
//  Created by mahmoud ezzat on 05/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class DetailsreservationCoordinator: Coordinator {
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
}
