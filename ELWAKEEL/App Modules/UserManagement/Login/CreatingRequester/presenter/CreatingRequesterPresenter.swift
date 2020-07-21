//
//  CreatingRequesterPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/4/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ICreatingRequesterPresenter: class {
	// do someting...
    func goVerification(type: String, id: Int)
    func showAlert(title: String, msg: String)
    func assignModel(newClient: CreatingRequesterModel.registerCleint)
}

class CreatingRequesterPresenter: ICreatingRequesterPresenter {
    func goVerification(type: String, id: Int) {
        view?.goVerification(type: type, id: id)
    }
    
    func assignModel(newClient: CreatingRequesterModel.registerCleint) {
        view?.assingModel(model: newClient)
    }
    
    func showAlert(title: String, msg: String) {
        view?.showAlert(title: title, msg: msg)
    }
    
    
	weak var view: ICreatingRequesterViewController?
	
	init(view: ICreatingRequesterViewController?) {
		self.view = view
	}
}
