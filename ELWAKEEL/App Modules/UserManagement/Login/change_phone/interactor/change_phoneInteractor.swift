//
//  change_phoneInteractor.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Ichange_phoneInteractor: class {
	var parameters: [String: Any]? { get set }
}

class change_phoneInteractor: Ichange_phoneInteractor {
    var presenter: Ichange_phonePresenter?
    var worker: Ichange_phoneWorker?
    var parameters: [String: Any]?

    init(presenter: Ichange_phonePresenter, worker: Ichange_phoneWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
