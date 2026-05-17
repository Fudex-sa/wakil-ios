//
//  MainuserCoordinator.swift
//  Wakil
//
//  Created by mahmos ezzat on 17/05/2026.
//  Copyright © 2026 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class MainuserCoordinator: Coordinator {
    typealias PresentingView = MainuserVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension MainuserCoordinator {
    
}
