//
//  NewsCoordinator.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class NewsCoordinator: Coordinator {
    typealias PresentingView = NewsVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension NewsCoordinator {
    func detailsnews(id: Int) {
        guard let scene = R.storyboard.newsDetailsStoryboard.newsDetailsVC() else { return }
        scene.newsId = id
        view?.push(scene)
    }
}
