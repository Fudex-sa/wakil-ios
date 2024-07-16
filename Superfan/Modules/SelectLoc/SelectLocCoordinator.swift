//
//  SelectLocCoordinator.swift
//  Superfan
//
//  Created by ADAM on 16/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class SelectLocCoordinator: Coordinator {
    typealias PresentingView = SelectLocVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension SelectLocCoordinator {
    
}
