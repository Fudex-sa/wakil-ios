//
//  shareAPPConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/10/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class shareAPPConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = shareAPPViewController()
        let router = shareAPPRouter(view: controller)
        let presenter = shareAPPPresenter(view: controller)
        let worker = shareAPPWorker()
        let interactor = shareAPPInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
