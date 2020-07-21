//
//  ForgetpasswordPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IForgetpasswordPresenter: class {
	// do someting...
    func goVerification(params: [String: Any])
    func showAlert(title: String, msg: String)
}

class ForgetpasswordPresenter: IForgetpasswordPresenter {
    func goVerification(params: [String : Any]) {
        view?.goverification(params: params)
    }
    
    func showAlert(title: String, msg: String) {
        view?.showAlert(title: title, msg: msg)
    }
    
    
    
	weak var view: IForgetpasswordViewController?
	
	init(view: IForgetpasswordViewController?) {
		self.view = view
	}
}
