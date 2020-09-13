//
//  change_addressInteractor.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Ichange_addressInteractor: class {
	var parameters: [String: Any]? { get set }
}

class change_addressInteractor: Ichange_addressInteractor {
    var presenter: Ichange_addressPresenter?
    var worker: Ichange_addressWorker?
    var parameters: [String: Any]?

    init(presenter: Ichange_addressPresenter, worker: Ichange_addressWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
