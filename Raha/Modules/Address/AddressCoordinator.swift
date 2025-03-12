//
//  AddressCoordinator.swift
//  Raha
//
//  Created by ADAM on 11/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class AddressCoordinator: Coordinator {
    typealias PresentingView = AddressVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension AddressCoordinator {
    
}
