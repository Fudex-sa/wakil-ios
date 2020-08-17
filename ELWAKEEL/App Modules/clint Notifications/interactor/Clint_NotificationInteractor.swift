//
//  Clint_NotificationInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IClint_NotificationInteractor: class {
	var parameters: [String: Any]? { get set }
}

class Clint_NotificationInteractor: IClint_NotificationInteractor {
    var presenter: IClint_NotificationPresenter?
    var worker: IClint_NotificationWorker?
    var parameters: [String: Any]?

    init(presenter: IClint_NotificationPresenter, worker: IClint_NotificationWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
