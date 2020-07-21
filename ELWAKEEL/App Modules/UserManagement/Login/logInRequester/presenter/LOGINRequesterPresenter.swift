//
//  LOGINRequesterPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/3/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ILOGINRequesterPresenter: class {
	// do someting...
    
      func showErrorAlert(title: String, msg: String)
    func navigateHome()
    func getUser(user: LOGINRequesterModel.loginSuccess)
}

class LOGINRequesterPresenter: ILOGINRequesterPresenter {
    func getUser(user: LOGINRequesterModel.loginSuccess) {
        view?.getUser(user: user)
    }
    
   
	weak var view: ILOGINRequesterViewController?
	
	init(view: ILOGINRequesterViewController?) {
		self.view = view
	}
    
    func showErrorAlert(title: String, msg: String){
        view?.showAlert(title: title, msg: msg)
    }
    func navigateHome() {
        view?.navigateToHome()
    }
    
}
