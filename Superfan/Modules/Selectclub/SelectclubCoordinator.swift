//
//  SelectclubCoordinator.swift
//  Superfan
//
//  Created by ADAM on 08/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class SelectclubCoordinator: Coordinator {
    typealias PresentingView = SelectclubVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension SelectclubCoordinator {
    
}
