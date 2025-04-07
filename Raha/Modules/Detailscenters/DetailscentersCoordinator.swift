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
    func bookdetaisl(){
        guard let scene = R.storyboard.bookserviceStoryboard.bookserviceVC() else { return }
        view?.push(scene)
    }
}
