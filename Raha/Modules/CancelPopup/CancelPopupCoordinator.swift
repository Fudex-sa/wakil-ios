//
//  CancelPopupCoordinator.swift
//  Raha
//
//  Created by mahmoud ezzat on 14/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class CancelPopupCoordinator: Coordinator {
    typealias PresentingView = CancelPopupVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension CancelPopupCoordinator {
    
}
