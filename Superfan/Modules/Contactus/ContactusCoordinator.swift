//
//  ContactusCoordinator.swift
//  Superfan
//
//  Created by ADAM on 10/07/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class ContactusCoordinator: Coordinator {
    typealias PresentingView = ContactusVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension ContactusCoordinator {
    
}
