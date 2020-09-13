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
        Indicator.sharedInstance.showIndicator()

        worker?.getCities(countries: countries, complition: { (error, success, data) in
            
            if success == true{
                self.presenter?.showCities(cities: data)
                Indicator.sharedInstance.hideIndicator()

            }
        })
    }
    
    func getcountries() {
        Indicator.sharedInstance.showIndicator()
        worker?.getcountries(complition: { (error, success, data) in
            if success == true{
        self.presenter?.showrespons(response: data)
                Indicator.sharedInstance.hideIndicator()

            }
            else{
                Indicator.sharedInstance.hideIndicator()
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
                if error?.message == "قيمة الحقل الهاتف مُستخدمة من قبل"
                {
                     self.presenter?.showAlert(title: Localization.errorLBL, msg: "قيمة الحقل الهاتف مُستخدمة من قبل")
                }
                else if error?.message ==  "قيمة الحقل البريد الالكتروني مُستخدمة من قبل"
                   {
                    self.presenter?.showAlert(title: Localization.errorLBL, msg:  "قيمة الحقل البريد الالكتروني مُستخدمة من قبل")
                    
                }
                else if error?.message == "حقل longitude مطلوب في حال ما إذا كان نوع التسجيل يساوي provider."{
                    self.presenter?.showAlert(title: Localization.errorLBL, msg: "هناك خطا في العنوان")
                }
                self.presenter?.showAlert(title: Localization.errorLBL, msg: error?.message ?? "error")
            }
            else if success == true{
                guard let response = responsData else {return}
            self.presenter?.newuser(user: response)
                if let id = response.id
                {
                  self.presenter?.navigateToNext(id: id)
                }
            
            }
           
            else{
                print("error")
            }
            
            
        })

    }
    
    
}
