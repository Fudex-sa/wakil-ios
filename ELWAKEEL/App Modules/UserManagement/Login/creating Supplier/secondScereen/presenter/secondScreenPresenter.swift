//
//  secondScreenPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/6/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IsecondScreenPresenter: class {
    func moveToverification(type: String)
    func assingNewProvider(provider: secondScreenModel.newUser)
    func showAlert(title: String, msg: String)
    
	// do someting...
}

class secondScreenPresenter: IsecondScreenPresenter {
    func moveToverification(type: String) {
        view?.moveToVerification(type: type)
    }
    
    
    
    func showAlert(title: String, msg: String) {
        view?.showAlert(title: title, msg: msg)
    }
    
//    func moveToHome() {
//        view?.moveToHome()
//    }
    
    func assingNewProvider(provider: secondScreenModel.newUser) {
        view?.assingNewProvider(provider: provider)
    }
    
	weak var view: IsecondScreenViewController?
	
	init(view: IsecondScreenViewController?) {
		self.view = view
	}
}
