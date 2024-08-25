//
//  DeleteaccountpopupCoordinator.swift
//  Wndo
//
//  Created by Adam on 13/12/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class DeleteaccountpopupCoordinator: Coordinator {
    typealias PresentingView = DeleteaccountpopupVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension DeleteaccountpopupCoordinator {
    func close() {
        view?.dismiss(animated: true, completion: nil)
    }
    
}
