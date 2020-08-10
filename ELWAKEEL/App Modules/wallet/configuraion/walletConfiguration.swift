//
//  walletConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/10/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class walletConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = walletViewController()
        let router = walletRouter(view: controller)
        let presenter = walletPresenter(view: controller)
        let worker = walletWorker()
        let interactor = walletInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
