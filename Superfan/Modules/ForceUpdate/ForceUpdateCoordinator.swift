//
//  ForceUpdateCoordinator.swift
//  Superfan
//
//  Created by ADAM on 14/10/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class ForceUpdateCoordinator: Coordinator {
    typealias PresentingView = ForceUpdateVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension ForceUpdateCoordinator {
    
}
