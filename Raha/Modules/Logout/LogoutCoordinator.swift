//
//  LogoutCoordinator.swift
//  Raha
//
//  Created by ADAM on 06/03/2025.
//  Copyright © 2025 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class LogoutCoordinator: Coordinator {
    typealias PresentingView = LogoutVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension LogoutCoordinator {
    func close() {
        view?.dismiss(animated: true, completion: nil)
    }
}
