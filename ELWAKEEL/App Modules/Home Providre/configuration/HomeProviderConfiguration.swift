//
//  HomeProviderConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class HomeProviderConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = HomeProviderViewController()
        let router = HomeProviderRouter(view: controller)
        let presenter = HomeProviderPresenter(view: controller)
        let worker = HomeProviderWorker()
        let interactor = HomeProviderInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
