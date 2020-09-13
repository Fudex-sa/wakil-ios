//
//  change_nameInteractor.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Ichange_nameInteractor: class {
	var parameters: [String: Any]? { get set }
}

class change_nameInteractor: Ichange_nameInteractor {
    var presenter: Ichange_namePresenter?
    var worker: Ichange_nameWorker?
    var parameters: [String: Any]?

    init(presenter: Ichange_namePresenter, worker: Ichange_nameWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
