//
//  SelecttypeCoordinator.swift
//  Wakil
//
//  Created by mahmos ezzat on 17/05/2026.
//  Copyright © 2026 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class SelecttypeCoordinator: Coordinator {
    typealias PresentingView = SelecttypeVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension SelecttypeCoordinator {
    func login(){
        guard let scene = R.storyboard.loginStoryboard.loginVC() else { return }
        view?.push(scene)
    }
}
