//
//  provider_logPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/13/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol Iprovider_logPresenter: class {
	// do someting...
    func assign_logs(logs: provider_logModel.Logs)
}

class provider_logPresenter: Iprovider_logPresenter {
    func assign_logs(logs: provider_logModel.Logs) {
        view?.assign_Logs(logs: logs)
    }
    
	weak var view: Iprovider_logViewController?
	
	init(view: Iprovider_logViewController?) {
		self.view = view
	}
}
