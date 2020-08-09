//
//  requestrecordConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class requestrecordConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = requestrecordViewController()
        let router = requestrecordRouter(view: controller)
        let presenter = requestrecordPresenter(view: controller)
        let worker = requestrecordWorker()
        let interactor = requestrecordInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
