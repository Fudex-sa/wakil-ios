//
//  GiftCoordinator.swift
//  Raha
//
//  Created by mahmoud ezzat on 10/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class GiftCoordinator: Coordinator {
    typealias PresentingView = GiftVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension GiftCoordinator {
    
}
