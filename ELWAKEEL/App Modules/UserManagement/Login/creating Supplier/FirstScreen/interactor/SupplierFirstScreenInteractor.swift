//
//  SupplierFirstScreenInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/5/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ISupplierFirstScreenInteractor: class {
	var parameters: [String: Any]? { get set }
}

class SupplierFirstScreenInteractor: ISupplierFirstScreenInteractor {
    var presenter: ISupplierFirstScreenPresenter?
    var worker: ISupplierFirstScreenWorker?
    var parameters: [String: Any]?

    init(presenter: ISupplierFirstScreenPresenter, worker: ISupplierFirstScreenWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
