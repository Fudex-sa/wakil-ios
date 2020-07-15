//
//  creatingPasswordInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IcreatingPasswordInteractor: class {
	var parameters: [String: Any]? { get set }
}

class creatingPasswordInteractor: IcreatingPasswordInteractor {
    var presenter: IcreatingPasswordPresenter?
    var worker: IcreatingPasswordWorker?
    var parameters: [String: Any]?

    init(presenter: IcreatingPasswordPresenter, worker: IcreatingPasswordWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
