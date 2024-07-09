//
//  ChangeClubCoordinator.swift
//  Superfan
//
//  Created by ADAM on 09/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class ChangeClubCoordinator: Coordinator {
    typealias PresentingView = ChangeClubVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension ChangeClubCoordinator {
    
}
