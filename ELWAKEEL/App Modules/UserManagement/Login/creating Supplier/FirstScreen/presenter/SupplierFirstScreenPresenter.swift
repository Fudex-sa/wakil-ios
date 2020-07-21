//
//  SupplierFirstScreenPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/5/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol ISupplierFirstScreenPresenter: class {
	// do someting...
    
    func showrespons(response: [SupplierFirstScreenModel.countries]?)
    func showCities(cities: [SupplierFirstScreenModel.Cities]?)
    func newuser(user: SupplierFirstScreenModel.newUser)
    func navigateToNext(id: Int)
    func showAlert(title: String, msg: String)
}

class SupplierFirstScreenPresenter: ISupplierFirstScreenPresenter {
    func showAlert(title: String, msg: String) {
        view?.alert(title: title, msg: msg)
    }
    
    
    
    func navigateToNext(id: Int) {
     view?.navigateToNext(id: id)
    }
    func newuser(user: SupplierFirstScreenModel.newUser) {
        view?.assingNewUser(user: user)
    }
    
    func showCities(cities: [SupplierFirstScreenModel.Cities]?) {
        view?.showCity(cities: cities)
        
    }
    
    
    
	weak var view: ISupplierFirstScreenViewController?
	
	init(view: ISupplierFirstScreenViewController?) {
		self.view = view
	}
    
    func showrespons(response: [SupplierFirstScreenModel.countries]?) {
        view?.showresponse(response: response!)
    }
    
}
