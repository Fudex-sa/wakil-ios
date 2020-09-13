//
//  change_addressConfiguration.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class change_addressConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = change_addressViewController()
        let router = change_addressRouter(view: controller)
        let presenter = change_addressPresenter(view: controller)
        let worker = change_addressWorker()
        let interactor = change_addressInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
