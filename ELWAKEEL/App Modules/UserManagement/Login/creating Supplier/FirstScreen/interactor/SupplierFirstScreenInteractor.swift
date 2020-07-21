//
//  SupplierFirstScreenInteractor.swift
//  ELWAKEEL
//
//  Created by HAMADA on 7/5/20.
//  Copyright (c) 2020 Fudex. All rights reserved.
//  Modify By:  * Ahmed Adam
//              * ibn.abuadam@gmail.com
//              * https://github.com/AhmedibnAdam

import UIKit
import LocalizationFramework

protocol ISupplierFirstScreenInteractor: class {
	var parameters: [String: Any]? { get set }
    func register(name: String,email:String,phone: String, country_code: String, type:String, accepted: Bool,password: String,city_ids: [Int], address: String, latitude: String, longitude: String)
    func getcountries()
    func getCities(countries: [Int])
}

class SupplierFirstScreenInteractor: ISupplierFirstScreenInteractor {
    func getCities(countries: [Int]) {
        worker?.getCities(countries: countries, complition: { (error, success, data) in
            
            if success == true{
                self.presenter?.showCities(cities: data)
            }
        })
    }
    
    func getcountries() {
        worker?.getcountries(complition: { (error, success, data) in
            if success == true{
        self.presenter?.showrespons(response: data)
                
            }
            else{
              print("Not Successed")
            }
        })
    
    }
    var presenter: ISupplierFirstScreenPresenter?
    var worker: ISupplierFirstScreenWorker?
    var parameters: [String: Any]?

    init(presenter: ISupplierFirstScreenPresenter, worker: ISupplierFirstScreenWorker) {
    	self.presenter = presenter
    	self.worker = worker
    }
    
    func register(name: String, email: String, phone: String, country_code: String, type: String, accepted: Bool, password: String, city_ids: [Int], address: String, latitude: String, longitude: String) {
        worker?.registerAPI(name: name, email: email, phone:phone, country_code: country_code, type: type, accepted: accepted, password: password, city_ids: city_ids, address: address, latitude: latitude, longitude: longitude, complition: { (error, success, responsData) in
            if error != nil
            {
                self.presenter?.showAlert(title: Localization.errorLBL, msg: error?.message ?? "error")
            }
            guard let response = responsData else {return}
            
                self.presenter?.newuser(user: response)
                self.presenter?.navigateToNext(id: response.id)
            
            
            
        })

    }
    
    
}
