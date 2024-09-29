//
//  FullscreenCoordinator.swift
//  Superfan
//
//  Created by ADAM on 29/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class FullscreenCoordinator: Coordinator {
    typealias PresentingView = FullscreenVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension FullscreenCoordinator {
    
}
