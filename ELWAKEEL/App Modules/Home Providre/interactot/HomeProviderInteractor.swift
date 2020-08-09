//
//  HomeProviderInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IHomeProviderInteractor: class {
	var parameters: [String: Any]? { get set }
}

class HomeProviderInteractor: IHomeProviderInteractor {
    var presenter: IHomeProviderPresenter?
    var worker: IHomeProviderWorker?
    var parameters: [String: Any]?

    init(presenter: IHomeProviderPresenter, worker: IHomeProviderWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
