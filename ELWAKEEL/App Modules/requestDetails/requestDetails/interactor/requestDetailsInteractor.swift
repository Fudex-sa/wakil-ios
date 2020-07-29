//
//  requestDetailsInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/27/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IrequestDetailsInteractor: class {
	var parameters: [String: Any]? { get set }
}

class requestDetailsInteractor: IrequestDetailsInteractor {
    var presenter: IrequestDetailsPresenter?
    var worker: IrequestDetailsWorker?
    var parameters: [String: Any]?

    init(presenter: IrequestDetailsPresenter, worker: IrequestDetailsWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
