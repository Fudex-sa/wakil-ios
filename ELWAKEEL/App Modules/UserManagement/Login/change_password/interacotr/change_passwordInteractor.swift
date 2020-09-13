//
//  change_passwordInteractor.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Ichange_passwordInteractor: class {
	var parameters: [String: Any]? { get set }
}

class change_passwordInteractor: Ichange_passwordInteractor {
    var presenter: Ichange_passwordPresenter?
    var worker: Ichange_passwordWorker?
    var parameters: [String: Any]?

    init(presenter: Ichange_passwordPresenter, worker: Ichange_passwordWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
