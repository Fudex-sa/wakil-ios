//
//  secondScreenInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/6/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IsecondScreenInteractor: class {
	var parameters: [String: Any]? { get set }
}

class secondScreenInteractor: IsecondScreenInteractor {
    var presenter: IsecondScreenPresenter?
    var worker: IsecondScreenWorker?
    var parameters: [String: Any]?

    init(presenter: IsecondScreenPresenter, worker: IsecondScreenWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
