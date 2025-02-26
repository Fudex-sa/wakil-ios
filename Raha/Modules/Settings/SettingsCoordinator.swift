//
//  SettingsCoordinator.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class SettingsCoordinator: Coordinator {
    typealias PresentingView = SettingsVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension SettingsCoordinator {
    
}
