//
//  editPresenter.swift
//  ELWAKEEL
//
//  Created by HAMADA on 8/11/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit

protocol IeditPresenter: class {
	// do someting...
    func assignOrganization(organizations: [addrequestModel.Organization])
    func assignCountries(countries: [addrequestModel.Organization])
    func assignCities(cities: [addrequestModel.Organization])
    func assign_request(request: editModel.edit)
    func goHome()

}


class editPresenter: IeditPresenter {
    func assign_request(request: editModel.edit) {
view?.assign_reqesut(request: request)
        
        
    }
    
	weak var view: IeditViewController?
	
	init(view: IeditViewController?) {
		self.view = view
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
    
}
