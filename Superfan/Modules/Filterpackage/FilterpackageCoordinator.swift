//
//  FilterpackageCoordinator.swift
//  Superfan
//
//  Created by ADAM on 08/12/2024.
//  Copyright © 2024 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class FilterpackageCoordinator: Coordinator {
    typealias PresentingView = FilterpackageVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension FilterpackageCoordinator {
    
}
