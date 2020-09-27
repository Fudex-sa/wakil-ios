//
//  addrequestPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/27/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IaddrequestPresenter: class {
    func assignOrganization(organizations: [addrequestModel.Organization])
    func assignCountries(countries: [addrequestModel.Organization])
    func assignCities(cities: [addrequestModel.Organization])
	// do someting...
    func goHome()
    func showAlert()
}

class addrequestPresenter: IaddrequestPresenter {
    func showAlert(){
        view?.showAlert()
    }
    func goHome() {
        view?.backToHome()
    }
    
    func assignCountries(countries: [addrequestModel.Organization]) {
        view?.assignCountries(countries: countries)
    }
    
    func assignCities(cities: [addrequestModel.Organization]) {
        view?.assignCities(cities: cities)
    }
    
    func assignOrganization(organizations: [addrequestModel.Organization]) {
        view?.assignorganization(organizations: organizations)
    }
    
	weak var view: IaddrequestViewController?
	
	init(view: IaddrequestViewController?) {
		self.view = view
	}
}
