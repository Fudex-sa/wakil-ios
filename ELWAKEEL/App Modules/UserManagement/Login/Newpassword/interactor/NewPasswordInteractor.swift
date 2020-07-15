//
//  NewPasswordInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/8/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol INewPasswordInteractor: class {
	var parameters: [String: Any]? { get set }
}

class NewPasswordInteractor: INewPasswordInteractor {
    var presenter: INewPasswordPresenter?
    var worker: INewPasswordWorker?
    var parameters: [String: Any]?

    init(presenter: INewPasswordPresenter, worker: INewPasswordWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
