//
//  accept_reuestConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/13/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class accept_reuestConfiguration {
    static func setup(parameters: [String: Any] = [:], request_id: Int) -> UIViewController {
        let controller = accept_reuestViewController()
        let router = accept_reuestRouter(view: controller)
        let presenter = accept_reuestPresenter(view: controller)
        let worker = accept_reuestWorker()
        let interactor = accept_reuestInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        controller.request_id = request_id
        return controller
    }
}
