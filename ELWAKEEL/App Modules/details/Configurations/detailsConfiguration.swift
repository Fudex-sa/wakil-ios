//
//  detailsConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/19/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class detailsConfiguration {
    static func setup(parameters: [String: Any] = [:], request_id: Int) -> UIViewController {
        let controller = detailsViewController()
        let router = detailsRouter(view: controller)
        let presenter = detailsPresenter(view: controller)
        let worker = detailsWorker()
        let interactor = detailsInteractor(presenter: presenter, worker: worker)
        controller.request_id = request_id
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
