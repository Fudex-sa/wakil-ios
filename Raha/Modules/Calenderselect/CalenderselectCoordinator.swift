//
//  CalenderselectCoordinator.swift
//  Raha
//
//  Created by mahmoud ezzat on 10/04/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class CalenderselectCoordinator: Coordinator {
    typealias PresentingView = CalenderselectVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension CalenderselectCoordinator {
    
}
