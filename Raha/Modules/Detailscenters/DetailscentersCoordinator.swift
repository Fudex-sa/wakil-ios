//
//  DetailscentersCoordinator.swift
//  Raha
//
//  Created by ADAM on 27/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class DetailscentersCoordinator: Coordinator {
    typealias PresentingView = DetailscentersVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension DetailscentersCoordinator {
    func bookservices(id:Int) {
        guard let scene = R.storyboard.bookserviceStoryboard.bookserviceVC() else { return }
        scene.centerId = id
        scene.loctype = view?.viewModel?.loctype.value ?? ""
        scene.selectservices = view?.selectservices ?? []
        view?.push(scene)
    }
    func rating(id:Int) {
        guard let scene = R.storyboard.clientRatingStoryboard.clientRatingVC() else { return }
        scene.centerId = id
        view?.push(scene)
    }
}
