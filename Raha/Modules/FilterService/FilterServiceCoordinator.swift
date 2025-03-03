//
//  FilterServiceCoordinator.swift
//  Raha
//
//  Created by ADAM on 02/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class FilterServiceCoordinator: Coordinator {
    typealias PresentingView = FilterServiceVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension FilterServiceCoordinator {
    
}
