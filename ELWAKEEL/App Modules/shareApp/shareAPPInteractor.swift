//
//  shareAPPInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/10/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IshareAPPInteractor: class {
	var parameters: [String: Any]? { get set }
}

class shareAPPInteractor: IshareAPPInteractor {
    var presenter: IshareAPPPresenter?
    var worker: IshareAPPWorker?
    var parameters: [String: Any]?

    init(presenter: IshareAPPPresenter, worker: IshareAPPWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
