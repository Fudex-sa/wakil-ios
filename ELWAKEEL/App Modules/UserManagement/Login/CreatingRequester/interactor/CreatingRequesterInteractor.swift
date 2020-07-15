//
//  CreatingRequesterInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/4/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ICreatingRequesterInteractor: class {
	var parameters: [String: Any]? { get set }
}

class CreatingRequesterInteractor: ICreatingRequesterInteractor {
    var presenter: ICreatingRequesterPresenter?
    var worker: ICreatingRequesterWorker?
    var parameters: [String: Any]?

    init(presenter: ICreatingRequesterPresenter, worker: ICreatingRequesterWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
