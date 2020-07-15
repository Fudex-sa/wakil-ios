//
//  LOGINInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/3/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ILOGINInteractor: class {
	var parameters: [String: Any]? { get set }
}

class LOGINInteractor: ILOGINInteractor {
    var presenter: ILOGINPresenter?
    var worker: ILOGINWorker?
    var parameters: [String: Any]?

    init(presenter: ILOGINPresenter, worker: ILOGINWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
