//
//  editRequestPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/28/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IeditRequestPresenter: class {
	// do someting...
    func asgniRequest(requestDetails: editRequestModel.RequestDetails)
    func cancel()
}

class editRequestPresenter: IeditRequestPresenter {
    func cancel() {
        view?.cancle()
    }
    
    
    
    func asgniRequest(requestDetails: editRequestModel.RequestDetails) {
        
        view?.asgniDetails(requestDetail: requestDetails)
    }
    
	weak var view: IeditRequestViewController?
	
	init(view: IeditRequestViewController?) {
		self.view = view
	}
}
