//
//  editRequestInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/28/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IeditRequestInteractor: class {
	var parameters: [String: Any]? { get set }
}

class editRequestInteractor: IeditRequestInteractor {
    var presenter: IeditRequestPresenter?
    var worker: IeditRequestWorker?
    var parameters: [String: Any]?

    init(presenter: IeditRequestPresenter, worker: IeditRequestWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
