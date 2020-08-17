//
//  request_detailsInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/14/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Irequest_detailsInteractor: class {
	var parameters: [String: Any]? { get set }
}

class request_detailsInteractor: Irequest_detailsInteractor {
    var presenter: Irequest_detailsPresenter?
    var worker: Irequest_detailsWorker?
    var parameters: [String: Any]?

    init(presenter: Irequest_detailsPresenter, worker: Irequest_detailsWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
