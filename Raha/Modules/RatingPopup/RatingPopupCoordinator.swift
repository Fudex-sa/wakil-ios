//
//  RatingPopupCoordinator.swift
//  Raha
//
//  Created by mahmoud ezzat on 14/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class RatingPopupCoordinator: Coordinator {
    typealias PresentingView = RatingPopupVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension RatingPopupCoordinator {
    
}
