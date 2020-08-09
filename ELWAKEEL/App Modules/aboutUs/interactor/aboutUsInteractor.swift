//
//  aboutUsInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/29/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IaboutUsInteractor: class {
	var parameters: [String: Any]? { get set }
}

class aboutUsInteractor: IaboutUsInteractor {
    var presenter: IaboutUsPresenter?
    var worker: IaboutUsWorker?
    var parameters: [String: Any]?

    init(presenter: IaboutUsPresenter, worker: IaboutUsWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
