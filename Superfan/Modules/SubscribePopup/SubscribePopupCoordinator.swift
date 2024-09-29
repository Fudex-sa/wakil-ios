//
//  SubscribePopupCoordinator.swift
//  Superfan
//
//  Created by ADAM on 29/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class SubscribePopupCoordinator: Coordinator {
    typealias PresentingView = SubscribePopupVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension SubscribePopupCoordinator {
    
}
