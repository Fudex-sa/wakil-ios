//
//  BackstageCoordinator.swift
//  Superfan
//
//  Created by ADAM on 12/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class BackstageCoordinator: Coordinator {
    typealias PresentingView = BackstageVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension BackstageCoordinator {
    
}
