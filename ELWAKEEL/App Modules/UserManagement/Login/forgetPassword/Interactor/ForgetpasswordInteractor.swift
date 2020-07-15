//
//  ForgetpasswordInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IForgetpasswordInteractor: class {
	var parameters: [String: Any]? { get set }
}

class ForgetpasswordInteractor: IForgetpasswordInteractor {
    var presenter: IForgetpasswordPresenter?
    var worker: IForgetpasswordWorker?
    var parameters: [String: Any]?

    init(presenter: IForgetpasswordPresenter, worker: IForgetpasswordWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
