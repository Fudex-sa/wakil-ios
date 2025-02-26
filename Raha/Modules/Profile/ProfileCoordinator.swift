//
//  ProfileCoordinator.swift
//  Raha
//
//  Created by ADAM on 26/02/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class ProfileCoordinator: Coordinator {
    typealias PresentingView = ProfileVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension ProfileCoordinator {
    
}
