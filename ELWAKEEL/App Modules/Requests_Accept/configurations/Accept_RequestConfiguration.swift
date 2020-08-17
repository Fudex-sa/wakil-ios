//
//  Accept_RequestConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/12/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class Accept_RequestConfiguration {
    static func setup(parameters: [String: Any] = [:], request_id: Int) -> UIViewController {
        let controller = Accept_RequestViewController()
        let router = Accept_RequestRouter(view: controller)
        let presenter = Accept_RequestPresenter(view: controller)
        let worker = Accept_RequestWorker()
        let interactor = Accept_RequestInteractor(presenter: presenter, worker: worker)
        controller.request_Id = request_id
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
