//
//  RegisterCoordinator.swift
//  Raha
//
//  Created by ADAM on 25/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class RegisterCoordinator: Coordinator {
    typealias PresentingView = RegisterVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension RegisterCoordinator {
    
}
