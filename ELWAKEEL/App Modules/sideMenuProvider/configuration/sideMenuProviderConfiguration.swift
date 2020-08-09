//
//  sideMenuProviderConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class sideMenuProviderConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = sideMenuProviderViewController()
        let router = sideMenuProviderRouter(view: controller)
        let presenter = sideMenuProviderPresenter(view: controller)
        let worker = sideMenuProviderWorker()
        let interactor = sideMenuProviderInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
