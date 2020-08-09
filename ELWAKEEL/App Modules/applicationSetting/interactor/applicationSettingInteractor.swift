//
//  applicationSettingInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/9/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IapplicationSettingInteractor: class {
	var parameters: [String: Any]? { get set }
}

class applicationSettingInteractor: IapplicationSettingInteractor {
    var presenter: IapplicationSettingPresenter?
    var worker: IapplicationSettingWorker?
    var parameters: [String: Any]?

    init(presenter: IapplicationSettingPresenter, worker: IapplicationSettingWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
}
