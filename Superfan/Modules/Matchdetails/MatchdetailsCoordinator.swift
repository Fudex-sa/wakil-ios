//
//  MatchdetailsCoordinator.swift
//  Superfan
//
//  Created by ADAM on 18/08/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class MatchdetailsCoordinator: Coordinator {
    typealias PresentingView = MatchdetailsVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension MatchdetailsCoordinator {
    
}
