//
//  walletInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/10/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IwalletInteractor: class {
	var parameters: [String: Any]? { get set }
}

class walletInteractor: IwalletInteractor {
    var presenter: IwalletPresenter?
    var worker: IwalletWorker?
    var parameters: [String: Any]?

    init(presenter: IwalletPresenter, worker: IwalletWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
