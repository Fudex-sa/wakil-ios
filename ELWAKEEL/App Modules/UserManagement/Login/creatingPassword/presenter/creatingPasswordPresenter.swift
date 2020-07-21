//
//  creatingPasswordPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/7/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IcreatingPasswordPresenter: class {
	// do someting...
    func alert(title: String, msg: String)
    func assignClient(client: creatingPasswordModel.NewClient)
    func GoHome()
}

class creatingPasswordPresenter: IcreatingPasswordPresenter {
    func GoHome() {
        view?.goHome()
    }
    
    func alert(title: String, msg: String) {
        view?.showAlert(title: title, msg: msg)
    }
    
    func assignClient(client: creatingPasswordModel.NewClient) {
        view?.assignResponse(newClient: client)
    }
    
	weak var view: IcreatingPasswordViewController?
	
	init(view: IcreatingPasswordViewController?) {
		self.view = view
	}
}
