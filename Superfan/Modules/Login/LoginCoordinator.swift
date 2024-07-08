//
//  LoginCoordinator.swift
//  Superfan
//
//  Created by ADAM on 07/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class LoginCoordinator: Coordinator {
    typealias PresentingView = LoginVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension LoginCoordinator {
    
}
