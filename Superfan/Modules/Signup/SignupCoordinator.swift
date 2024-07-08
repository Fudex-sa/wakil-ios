//
//  SignupCoordinator.swift
//  Superfan
//
//  Created by ADAM on 07/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class SignupCoordinator: Coordinator {
    typealias PresentingView = SignupVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension SignupCoordinator {
    
}
