//
//  sideMenuProviderInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IsideMenuProviderInteractor: class {
	var parameters: [String: Any]? { get set }
}

class sideMenuProviderInteractor: IsideMenuProviderInteractor {
    var presenter: IsideMenuProviderPresenter?
    var worker: IsideMenuProviderWorker?
    var parameters: [String: Any]?

    init(presenter: IsideMenuProviderPresenter, worker: IsideMenuProviderWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
