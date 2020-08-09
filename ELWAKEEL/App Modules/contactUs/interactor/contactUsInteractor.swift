//
//  contactUsInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IcontactUsInteractor: class {
	var parameters: [String: Any]? { get set }
}

class contactUsInteractor: IcontactUsInteractor {
    var presenter: IcontactUsPresenter?
    var worker: IcontactUsWorker?
    var parameters: [String: Any]?

    init(presenter: IcontactUsPresenter, worker: IcontactUsWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
