//
//  AddPostCoordinator.swift
//  Superfan
//
//  Created by ADAM on 01/09/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class AddPostCoordinator: Coordinator {
    typealias PresentingView = AddPostVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension AddPostCoordinator {
    
}
