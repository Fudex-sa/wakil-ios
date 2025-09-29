//
//  PaymentmethodCoordinator.swift
//  Raha
//
//  Created by mahmoud ezzat on 21/09/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class PaymentmethodCoordinator: Coordinator {
    typealias PresentingView = PaymentmethodVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension PaymentmethodCoordinator {
    
}
