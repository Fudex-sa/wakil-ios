//
//  change_cityConfiguration.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class change_cityConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = change_cityViewController()
        let router = change_cityRouter(view: controller)
        let presenter = change_cityPresenter(view: controller)
        let worker = change_cityWorker()
        let interactor = change_cityInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
