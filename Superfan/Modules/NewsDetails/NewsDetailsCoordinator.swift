//
//  NewsDetailsCoordinator.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class NewsDetailsCoordinator: Coordinator {
    typealias PresentingView = NewsDetailsVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension NewsDetailsCoordinator {
    func detailsclub(id: Int) {
        guard let scene = R.storyboard.clubdetailsStoryboard.clubdetailsVC() else { return }
        scene.clubId = id
        view?.push(scene)
    }
}
