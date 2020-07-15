//
//  LOGINRequesterInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/3/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ILOGINRequesterInteractor: class {
	var parameters: [String: Any]? { get set }
}

class LOGINRequesterInteractor: ILOGINRequesterInteractor {
    var presenter: ILOGINRequesterPresenter?
    var worker: ILOGINRequesterWorker?
    var parameters: [String: Any]?

    init(presenter: ILOGINRequesterPresenter, worker: ILOGINRequesterWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
