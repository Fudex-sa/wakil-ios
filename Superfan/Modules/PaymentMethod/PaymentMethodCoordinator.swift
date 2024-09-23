//
//  PaymentMethodCoordinator.swift
//  Superfan
//
//  Created by ADAM on 23/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class PaymentMethodCoordinator: Coordinator {
    typealias PresentingView = PaymentMethodVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension PaymentMethodCoordinator {
    
}
