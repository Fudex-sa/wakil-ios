//
//  BookserviceCoordinator.swift
//  Raha
//
//  Created by mahmoud ezzat on 07/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class BookserviceCoordinator: Coordinator {
    typealias PresentingView = BookserviceVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension BookserviceCoordinator {
    
}
