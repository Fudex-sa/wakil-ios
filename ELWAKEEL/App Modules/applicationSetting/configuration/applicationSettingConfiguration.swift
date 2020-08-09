//
//  applicationSettingConfiguration.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import Foundation
import UIKit

class applicationSettingConfiguration {
    static func setup(parameters: [String: Any] = [:]) -> UIViewController {
        let controller = applicationSettingViewController()
        let router = applicationSettingRouter(view: controller)
        let presenter = applicationSettingPresenter(view: controller)
        let worker = applicationSettingWorker()
        let interactor = applicationSettingInteractor(presenter: presenter, worker: worker)
        
        controller.interactor = interactor
        controller.router = router
        interactor.parameters = parameters
        return controller
    }
}
