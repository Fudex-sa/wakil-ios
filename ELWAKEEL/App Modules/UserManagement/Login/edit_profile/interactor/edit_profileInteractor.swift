//
//  edit_profileInteractor.swift
//  ELWAKEEL
//
//  Created by Boo Doo on 9/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Iedit_profileInteractor: class {
	var parameters: [String: Any]? { get set }
}

class edit_profileInteractor: Iedit_profileInteractor {
    var presenter: Iedit_profilePresenter?
    var worker: Iedit_profileWorker?
    var parameters: [String: Any]?

    init(presenter: Iedit_profilePresenter, worker: Iedit_profileWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
