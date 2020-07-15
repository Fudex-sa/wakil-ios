//
//  registraionTypeInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IregistraionTypeInteractor: class {
	var parameters: [String: Any]? { get set }
}

class registraionTypeInteractor: IregistraionTypeInteractor {
    var presenter: IregistraionTypePresenter?
    var worker: IregistraionTypeWorker?
    var parameters: [String: Any]?

    init(presenter: IregistraionTypePresenter, worker: IregistraionTypeWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
