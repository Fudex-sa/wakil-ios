//
//  FaqCoordinator.swift
//  Raha
//
//  Created by ADAM on 03/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class FaqCoordinator: Coordinator {
    typealias PresentingView = FaqVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension FaqCoordinator {
    
}
