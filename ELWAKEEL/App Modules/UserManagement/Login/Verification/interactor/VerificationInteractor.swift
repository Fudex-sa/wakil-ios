//
//  VerificationInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/4/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IVerificationInteractor: class {
	var parameters: [String: Any]? { get set }
}

class VerificationInteractor: IVerificationInteractor {
    var presenter: IVerificationPresenter?
    var worker: IVerificationWorker?
    var parameters: [String: Any]?

    init(presenter: IVerificationPresenter, worker: IVerificationWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
