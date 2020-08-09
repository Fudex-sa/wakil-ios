//
//  termsInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ItermsInteractor: class {
	var parameters: [String: Any]? { get set }
}

class termsInteractor: ItermsInteractor {
    var presenter: ItermsPresenter?
    var worker: ItermsWorker?
    var parameters: [String: Any]?

    init(presenter: ItermsPresenter, worker: ItermsWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
