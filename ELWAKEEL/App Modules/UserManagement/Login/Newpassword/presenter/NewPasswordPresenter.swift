//
//  NewPasswordPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/8/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol INewPasswordPresenter: class {
    func showAlert(title: String, msg: String)
    func GoHome()
	// do someting...
}

class NewPasswordPresenter: INewPasswordPresenter {
    func GoHome() {
        view?.GoHome()
    }
    
    func showAlert(title: String, msg: String) {
        view?.showAlert(title: title, msg: msg)
    }
    
	weak var view: INewPasswordViewController?
	
	init(view: INewPasswordViewController?) {
		self.view = view
	}
}
