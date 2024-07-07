//
//  OnboardingCoordinator.swift
//  Wndo
//
//  Created by Adam on 27/07/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Coordinator
class OnboardingCoordinator: Coordinator {
    typealias PresentingView = OnboardingVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension OnboardingCoordinator {
    
}
