//
//  CancelOrderCoordinator.swift
//  Raha
//
//  Created by mahmoud ezzat on 06/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class CancelOrderCoordinator: Coordinator {
    typealias PresentingView = CancelOrderVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension CancelOrderCoordinator {
    
}
