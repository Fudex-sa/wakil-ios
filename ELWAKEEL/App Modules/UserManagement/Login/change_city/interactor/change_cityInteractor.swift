//
//  change_cityInteractor.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Ichange_cityInteractor: class {
	var parameters: [String: Any]? { get set }
}

class change_cityInteractor: Ichange_cityInteractor {
    var presenter: Ichange_cityPresenter?
    var worker: Ichange_cityWorker?
    var parameters: [String: Any]?

    init(presenter: Ichange_cityPresenter, worker: Ichange_cityWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
