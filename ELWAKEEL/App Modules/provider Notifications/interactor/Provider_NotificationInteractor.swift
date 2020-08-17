//
//  Provider_NotificationInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IProvider_NotificationInteractor: class {
	var parameters: [String: Any]? { get set }
}

class Provider_NotificationInteractor: IProvider_NotificationInteractor {
    var presenter: IProvider_NotificationPresenter?
    var worker: IProvider_NotificationWorker?
    var parameters: [String: Any]?

    init(presenter: IProvider_NotificationPresenter, worker: IProvider_NotificationWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
